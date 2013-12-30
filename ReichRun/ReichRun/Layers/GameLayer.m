//
//  GameLayer.m
//  ReichRun
//
//  Created by Gurkan Tumer on 30/12/13.
//  Copyright (c) 2013 Studio Nord. All rights reserved.
//

#import "GameLayer.h"
#import "GameManager.h"

@implementation GameLayer

@synthesize playerMovement;
@synthesize enemyArray;
@synthesize player;
@synthesize crossHair;

-(id) init
{
	if( (self=[super init]) )
    {
        if(!kTOGGLE_DEBUG)[NSCursor hide];
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        playerMovement = [[NSMutableArray alloc] init];
        [playerMovement addObject:@"NO"];
        [playerMovement addObject:@"NO"];
        [playerMovement addObject:@"NO"];
        [playerMovement addObject:@"NO"];
        
        enemyArray = [[NSMutableArray alloc] init];
        
        for (int i = 0; i<10; i++)
        {
            Enemy *enemy = [[Enemy alloc] initWithFile:@"char.png"];
            [enemy setUpSchedule];
            float screenWidth = winSize.width;
            float screenHeight = winSize.height;
            
            [enemy setPosition:CGPointMake(arc4random() % (int) screenWidth, arc4random() % (int)screenHeight)];
            
            NSLog(@"enemy : %f,%f", enemy.position.x,enemy.position.y);
            
            [enemyArray addObject:enemy];
            [self addChild:enemy z:2];
        }
        
        isSpacePressed = NO;
        
        //CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        //self.contentSize = winSize;
        
        [[GameManager sharedManager] setKeyboardEnabledState:YES];
        [[GameManager sharedManager] setMouseEnabledState:YES];
        [[GameManager sharedManager] setGameEnabledState:YES];
        
        CCLayerColor* colorLayer = [CCLayerColor layerWithColor:CC_GRAY];
        colorLayer.tag = 3000;
        [self addChild:colorLayer z:0];
        
        player = [[Player alloc] initWithFile:@"char.png"];
        [player setPosition:CGPointMake(200, 200)];
        [self addChild:player z:1];
        
        crossHair = [[CCSprite alloc] initWithFile:@"crosshair.png"];
        [self addChild:crossHair z:2];
        
        //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowDidResize:) name:NSWindowDidResizeNotification object:nil];
        
        [self scheduleUpdate];
	}
	return self;
}

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
    GameLayer *layer = [GameLayer node];
	
	[scene addChild: layer];
	return scene;
}

- (void)windowDidResize:(NSNotification *)notification
{
    //self.contentSize = [[CCDirector sharedDirector] winSize];
    //CCLayerColor* colorLayer = (CCLayerColor *)[self getChildByTag:3000];
    //colorLayer.contentSize = self.contentSize;
}

- (void) update:(ccTime)dt
{
    if([[GameManager sharedManager] getGameEnabledState]){
        // Get player current position
        CGFloat playerPositionX = player.position.x;
        CGFloat playerPositionY = player.position.y;
        
        // Up Arrow or W
        if ([[playerMovement objectAtIndex:0] isEqualToString:@"YES"])
        {
            if (player.velocityY < player.maxSpeed) {
                player.velocityY += player.acceleration;
            }
        }
        // Down Arrow or S
        if ([[playerMovement objectAtIndex:1] isEqualToString:@"YES"])
        {
            if (player.velocityY > 0 - player.maxSpeed) {
                player.velocityY -= player.acceleration;
            }
        }
        // left Arrow or D
        if ([[playerMovement objectAtIndex:2] isEqualToString:@"YES"])
        {
            if (player.velocityX < player.maxSpeed) {
                player.velocityX += player.acceleration;
            }
        }
        // Right Arrow or A
        if ([[playerMovement objectAtIndex:3] isEqualToString:@"YES"])
        {
            if (player.velocityX > 0 - player.maxSpeed) {
                player.velocityX -= player.acceleration;
            }
        }
        
        // Get window size
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        // Check if player stays within screen height
        if (playerPositionX > winSize.width - 30) {
            player.velocityX = player.velocityX * -0.8;
            playerPositionX = playerPositionX + player.velocityX;
        } else if (playerPositionX < 30) {
            player.velocityX = player.velocityX * -0.8;
            playerPositionX = playerPositionX + player.velocityX;
        }
        
        // Check if player stays within screen width
        if (playerPositionY > winSize.height - 30) {
            player.velocityY = player.velocityY * -0.8;
            playerPositionY = playerPositionY + player.velocityY;
        } else if (playerPositionY < 30) {
            player.velocityY = player.velocityY * -0.8;
            playerPositionY = playerPositionY + player.velocityY;
        }
        
        // Calculate friction
        player.velocityX *= player.friction;
        player.velocityY *= player.friction;
        
        // Update position
        player.position = ccp(playerPositionX += player.velocityX, playerPositionY += player.velocityY);
        
        [player setPositionGraphic:playerMovement];
    }
    
    for (int i=0; i<enemyArray.count; i++) {
        Enemy *enemy = (Enemy *) [enemyArray objectAtIndex:i];
        CGFloat distanceApart = ccpDistance(enemy.position, player.position);
        NSLog(@"%f",distanceApart);
        if (distanceApart<200) {
            [enemy updateTargetPosition:player.position];
            [enemy moveToPlayer];
        }
        //[enemy updateTargetPosition:player.position];
        //[enemy move];
    }
}

- (BOOL) ccKeyDown:(NSEvent*)event
{
    NSString * character = [event characters];
    unichar keyCode = [character characterAtIndex: 0];
    
    // keyboard available
    if ([[GameManager sharedManager] getKeyboardEnabledState])
    {
        if (kTOGGLE_DEBUG) { NSLog(@"%hu",keyCode); }
        
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
        //CGPoint clickedAt = [(CCDirectorMac*)[CCDirector sharedDirector] convertEventToGL:event];
        //NSLog(@"clickedAt : %f",clickedAt.x);
        //NSLog(@"clickedAt : %f",clickedAt.y);
    }
    return YES;
}

- (BOOL) ccMouseMoved:(NSEvent *)event
{
    if ([[GameManager sharedManager] getMouseEnabledState]) {
        
        if(!kTOGGLE_DEBUG) [NSCursor hide];
        //CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        CGPoint pointedAt = [(CCDirectorMac*)[CCDirector sharedDirector] convertEventToGL:event];
        //NSLog(@"pointedAt : %f",pointedAt.x);
        //NSLog(@"pointedAt : %f",pointedAt.y);
        crossHair.position = pointedAt;
        
    }else{
        [NSCursor unhide];
    }
    
    return YES;
}

- (void) dealloc
{
    [self removeAllChildrenWithCleanup:YES];
    
    [playerMovement removeAllObjects];
    playerMovement = nil;
    
    [super dealloc];
}

@end
