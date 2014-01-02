//
//  GameLayer.m
//  ReichRun
//
//  Created by Gurkan Tumer on 30/12/13.
//  Copyright (c) 2013 Studio Nord. All rights reserved.
//

#import "GameLayer.h"
#import "GameManager.h"
#import "LevelManager.h"

#import "CCShake.h"

@implementation GameLayer

@synthesize playerMovement;
@synthesize player;
@synthesize crossHair;
@synthesize ground;

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
    GameLayer *layer = [GameLayer node];
	   
	[scene addChild: layer];
    
    return scene;
}

-(id) init
{
	if( (self=[super init]) )
    {
        if(!kTOGGLE_DEBUG)[NSCursor hide];
        
        //CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        playerMovement = [[NSMutableArray alloc] init];
        [playerMovement addObject:@"NO"];
        [playerMovement addObject:@"NO"];
        [playerMovement addObject:@"NO"];
        [playerMovement addObject:@"NO"];
                
        isSpacePressed = NO;
        
        [[GameManager sharedManager] setKeyboardEnabledState:YES];
        [[GameManager sharedManager] setMouseEnabledState:YES];
        [[GameManager sharedManager] setGameEnabledState:YES];

        ground = [[Ground alloc] init];
        [self addChild:ground];
        
        player = [[Player alloc] initWithGround:ground];
        [ground addChild:player z:1];
        
        for (int i = 0; i<[LevelManager sharedManager].enemyCount; i++)
        {
            Enemy *enemy = [[Enemy alloc] initWithGround:ground];
            [ground addChild:enemy z:2];
        }
        
        for (int ii = 0; ii<[LevelManager sharedManager].healthCount; ii++)
        {
            HealthPack *health = [[HealthPack alloc] init];            
            [ground addChild:health z:2];
        }
        
        crossHair = [[CCSprite alloc] initWithFile:@"crosshair.png"];
        [ground addChild:crossHair z:2];
    
        [self scheduleUpdate];
	}
	return self;
}

- (void) update:(ccTime)dt
{
    [self updateGlobalPositions];
        
    crossHair.position = crossHairPosition;
    
    if([[GameManager sharedManager] getGameEnabledState]){
        
        //[ground updatePosition:playerMovement];
        [player updatePosition:playerMovement];
        
        for (int i=0; i<[[LevelManager sharedManager] healthArray].count; i++) {
            HealthPack *health = (HealthPack *) [[[LevelManager sharedManager] healthArray] objectAtIndex:i];
            CGFloat distanceApart = ccpDistance(health.position, player.position);
            
            if (distanceApart<100)
            {
                [health updateTargetPosition:player.position];
                [health moveToPlayer];
            }
        }
        
        for (int i=0; i<[[LevelManager sharedManager] enemyArray].count; i++) {
            Enemy *enemy = (Enemy *) [[[LevelManager sharedManager] enemyArray] objectAtIndex:i];
            CGFloat distanceApart = ccpDistance(enemy.position, player.position);
            
            if (distanceApart<200)
            {
                [enemy updateTargetPosition:player.position];
                [enemy moveToPlayer];
            }else{
                if (!enemy.isIDLE) {
                    [enemy updateTargetPosition:player.position];
                    [enemy moveToPlayer];
                }
            }
            
            for (int j=0; j<[[LevelManager sharedManager] bulletArray].count; j++) {
                CCSprite *bullet = (CCSprite*)[[[LevelManager sharedManager] bulletArray] objectAtIndex:j];
                CGFloat bulletDistanceApart = ccpDistance(enemy.position, bullet.position);
                if (bulletDistanceApart<15)
                {
                    [[[LevelManager sharedManager] bulletArray] removeObject:bullet];
                    [ground removeChild:bullet cleanup:YES];
                    NSLog(@"hit enemy");
                    enemy.isIDLE = NO;
                    [enemy updateHealth:[LevelManager sharedManager].healthValue * -1];
                }
            }
        }
        
        for (int i=0; i<[[LevelManager sharedManager] enemyBulletArray].count; i++) {
            CCSprite *bullet = (CCSprite*)[[[LevelManager sharedManager] enemyBulletArray] objectAtIndex:i];
            CGFloat distanceApart = ccpDistance(bullet.position, player.position);
            if (distanceApart<15)
            {
                NSLog(@"hit player");
                
                [[[LevelManager sharedManager] enemyBulletArray] removeObject:bullet];
                [ground removeChild:bullet cleanup:YES];
                
                NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
                [userInfo setValue:[NSString stringWithFormat:@"%f",player.position.x] forKey:@"locationX"];
                [userInfo setValue:[NSString stringWithFormat:@"%f",player.position.y] forKey:@"locationY"];
                [[NSNotificationCenter defaultCenter] postNotificationName:kHEALTH_DROP object:nil userInfo:userInfo];
            }
        }
        
        float centerX, centerY, centerZ;
        float eyeX, eyeY, eyeZ;
        [self.camera centerX:&centerX centerY:&centerY centerZ:&centerZ];
        [self.camera eyeX:&eyeX eyeY:&eyeY eyeZ:&eyeZ];
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        centerX = eyeX = (player.position.x) - (winSize.width*.5f);
        centerY = eyeY = (player.position.y) - (winSize.height*.5f);
        
        centerX = eyeX = clampf(centerX, 0.0f, ground.contentSize.width - winSize.width);
        centerY = eyeY = clampf(centerY, 0.0f, ground.contentSize.height - winSize.height);
        
        [self.camera setCenterX:centerX centerY:centerY centerZ:centerZ];
        [self.camera setEyeX:eyeX eyeY:eyeY eyeZ:eyeZ];
    }
}

- (BOOL) ccKeyDown:(NSEvent*)event
{
    NSString * character = [event characters];
    unichar keyCode = [character characterAtIndex: 0];
    
    // keyboard available
    if ([[GameManager sharedManager] getKeyboardEnabledState])
    {
        //if (kTOGGLE_DEBUG) { NSLog(@"%hu",keyCode); }
        
        if (keyCode == kCAPS_ON_UP || keyCode== kCAPS_OFF_UP) { [playerMovement replaceObjectAtIndex:0 withObject:@"YES"]; } // Up
        if (keyCode == kCAPS_ON_DOWN || keyCode== kCAPS_OFF_DOWN) { [playerMovement replaceObjectAtIndex:1 withObject:@"YES"]; } // Down
        if (keyCode == kCAPS_ON_LEFT || keyCode== kCAPS_OFF_LEFT) { [playerMovement replaceObjectAtIndex:2 withObject:@"YES"]; } // Left
        if (keyCode == kCAPS_ON_RIGHT || keyCode== kCAPS_OFF_RIGHT) { [playerMovement replaceObjectAtIndex:3 withObject:@"YES"]; } // Right
        if (keyCode == 32) { isSpacePressed = YES; } // space
    }
    
    if (keyCode == 27) // escape
    {
        /*if ([[GameManager sharedManager] getKeyboardEnabledState]){
            [[GameManager sharedManager] setKeyboardEnabledState:NO];
        }else{
            [[GameManager sharedManager] setKeyboardEnabledState:YES];
        }*/
    }
    
    return YES;
}

- (BOOL) ccKeyUp:(NSEvent *)event
{
    NSString * character = [event characters];
    unichar keyCode = [character characterAtIndex: 0];
    
    // keyboard available
    if ([[GameManager sharedManager] getKeyboardEnabledState])
    {
        // Set unpressed key to false
        if (keyCode == kCAPS_ON_UP || keyCode== kCAPS_OFF_UP) { [playerMovement replaceObjectAtIndex:0 withObject:@"NO"]; } // Up
        if (keyCode == kCAPS_ON_DOWN || keyCode== kCAPS_OFF_DOWN) { [playerMovement replaceObjectAtIndex:1 withObject:@"NO"]; } // Down
        if (keyCode == kCAPS_ON_LEFT || keyCode== kCAPS_OFF_LEFT) { [playerMovement replaceObjectAtIndex:2 withObject:@"NO"]; } // Left
        if (keyCode == kCAPS_ON_RIGHT || keyCode== kCAPS_OFF_RIGHT) { [playerMovement replaceObjectAtIndex:3 withObject:@"NO"]; } // Right
        if (keyCode == 32) { isSpacePressed = NO; } // space
    }
    
    return YES;
}

-(BOOL) ccMouseDown:(NSEvent *)event
{
    if ([[GameManager sharedManager] getMouseEnabledState]) {
        mousePosition = [(CCDirectorMac*)[CCDirector sharedDirector] convertEventToGL:event];
        [self updateGlobalPositions];
        [player fireBullet:crossHairPosition atLayer:self];
        
        [self runAction:[CCShake actionWithDuration:.05f amplitude:ccp(6,6) dampening:true shakes:4]];
    }
    return YES;
}

- (BOOL) ccMouseMoved:(NSEvent *)event
{
    if ([[GameManager sharedManager] getMouseEnabledState]) {
        
        if(!kTOGGLE_DEBUG) [NSCursor hide];
        
        mousePosition = [(CCDirectorMac*)[CCDirector sharedDirector] convertEventToGL:event];
        [self updateGlobalPositions];
        
    }else{
        [NSCursor unhide];
    }
    
    return YES;
}

- (void) notificationHandler:(NSNotification*)notification
{
    NSLog(@"NotificationLayer : :%@, %@", notification.name,[notification.userInfo description]);
    if ([notification.name isEqualToString:kHEALTH_ADD]) {
        float xVal = [[notification.userInfo valueForKey:@"locationX"] floatValue];
        float yVal = [[notification.userInfo valueForKey:@"locationY"] floatValue]+50;
        CGPoint point = ccp(xVal, yVal);
        [self addLabelWithText:[NSString stringWithFormat:@"+%i",(int)[[LevelManager sharedManager] healthValue]] atPoint:point];
    }
    if ([notification.name isEqualToString:kHEALTH_DROP]) {
        float xVal = [[notification.userInfo valueForKey:@"locationX"] floatValue];
        float yVal = [[notification.userInfo valueForKey:@"locationY"] floatValue]+50;
        CGPoint point = ccp(xVal, yVal);
        [self addLabelWithText:[NSString stringWithFormat:@"-%i",(int)[[LevelManager sharedManager] healthValue]] atPoint:point];
    }
    
    if ([notification.name isEqualToString:kHEALTH_ZERO]) {
        NSLog(@"GAME ENDED");
        
        //[[GameManager sharedManager] setKeyboardEnabledState:NO];
        //[[GameManager sharedManager] setMouseEnabledState:NO];
        //[[GameManager sharedManager] setGameEnabledState:NO];
        
        CCLayerColor *color = [[CCLayerColor alloc] initWithColor:ccc4(0, 0, 0, 150) width:2000 height:2000];
        [self addChild:color];
        
        id action1 = [CCFadeIn actionWithDuration:.5];
        id call = [CCCallFunc actionWithTarget:self selector:@selector(gameEnded)];
        id delay = [CCDelayTime actionWithDuration:1];
        CCSequence* sequence = [CCSequence actions:action1,delay,call, nil];
        [color runAction:sequence];
        
        // CLEAR ALL
        
    }
}

- (void) gameEnded
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[[SceneManager sharedSceneManager] sceneWithID:1] withColor:ccBLACK]];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kHEALTH_ADD object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kHEALTH_DROP object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kHEALTH_ZERO object:nil];
    
    [self removeAllChildrenWithCleanup:YES];
    player = nil;
    [playerMovement removeAllObjects];
    playerMovement = nil;
    
}

- (void) dealloc
{
    [super dealloc];
}

@end
