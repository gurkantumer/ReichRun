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
@synthesize _contactListener;

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
        [self initPhysics];
        
        _contactListener = new BoxContactListener();
        world->SetContactListener(_contactListener);
        
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
        [[GameManager sharedManager] setGameState:YES];

        ground = [[Ground alloc] init];
        [self addChild:ground];
        
        player = [[Player alloc] initWithGround:ground];
        [ground addChild:player z:1];
        
        [self addBoxBodyForSprite:player];
        
        for (int i = 0; i<[LevelManager sharedManager].enemyCount; i++)
        {
            Enemy *enemy = [[Enemy alloc] initWithGround:ground];
            [ground addChild:enemy z:2];
            [self addBoxBodyForSprite:enemy];
        }
        
        for (int ii = 0; ii<[LevelManager sharedManager].healthCount; ii++)
        {
            HealthPack *health = [[HealthPack alloc] initAtPoint:CGPointMake(arc4random() % (int) [LevelManager sharedManager].gameAreaSize.width, arc4random() % (int)[LevelManager sharedManager].gameAreaSize.height)];
            [ground addChild:health z:2];
        }
        
        crossHair = [[CCSprite alloc] initWithFile:@"crosshair.png"];
        [ground addChild:crossHair z:2];
    
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationHandler:) name:kHEALTH_ADD object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationHandler:) name:kHEALTH_DROP object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationHandler:) name:kHEALTH_ZERO object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationHandler:) name:kNO_ENEMY_LEFT object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationHandler:) name:kGENERATE_DROP object:nil];
        
        [self scheduleUpdate];
        [self schedule:@selector(tick:)];
	}
	return self;
}
- (void)tick:(ccTime)dt {
    
    int32 velocityIterations = 8;
	int32 positionIterations = 1;
	
	world->Step(dt, velocityIterations, positionIterations);
    
    
    // Loop through all of the Box2D bodies in our Box2D world..
    for(b2Body *b = world->GetBodyList(); b; b=b->GetNext()) {
        
        // See if there's any user data attached to the Box2D body
        // There should be, since we set it in addBoxBodyForSprite
        if (b->GetUserData() != NULL) {
            
            // We know that the user data is a sprite since we set
            // it that way, so cast it...
            CCSprite *sprite = (CCSprite *)b->GetUserData();
            
            // Convert the Cocos2D position/rotation of the sprite to the Box2D position/rotation
            b2Vec2 b2Position = b2Vec2(sprite.position.x/PTM_RATIO,
                                       sprite.position.y/PTM_RATIO);
            float32 b2Angle = -1 * CC_DEGREES_TO_RADIANS(sprite.rotation);
            
            // Update the Box2D position/rotation to match the Cocos2D position/rotation
            b->SetTransform(b2Position, b2Angle);
        }
    }
}

-(void) initPhysics
{
	
	CGSize s = [[LevelManager sharedManager] gameAreaSize];
    
	b2Vec2 gravity = b2Vec2(0.0f, 0.0f);
	world = new b2World(gravity);
    
	// Do we want to let bodies sleep?
	world->SetAllowSleeping(false);
	
	world->SetContinuousPhysics(true);
	
	m_debugDraw = new GLESDebugDraw( PTM_RATIO );
	world->SetDebugDraw(m_debugDraw);
	
	uint32 flags = 0;
	flags += b2Draw::e_shapeBit;
	//		flags += b2Draw::e_jointBit;
	//		flags += b2Draw::e_aabbBit;
	//		flags += b2Draw::e_pairBit;
	//		flags += b2Draw::e_centerOfMassBit;
	m_debugDraw->SetFlags(flags);
	
	
	// Define the ground body.
	b2BodyDef groundBodyDef;
	groundBodyDef.position.Set(0, 0); // bottom-left corner
	
	// Call the body factory which allocates memory for the ground body
	// from a pool and creates the ground box shape (also from a pool).
	// The body is also added to the world.
	b2Body* groundBody = world->CreateBody(&groundBodyDef);
	
	// Define the ground box shape.
	b2EdgeShape groundBox;
	
	// bottom
	
	groundBox.Set(b2Vec2(0,0), b2Vec2(s.width/PTM_RATIO,0));
	groundBody->CreateFixture(&groundBox,0);
	
	// top
	groundBox.Set(b2Vec2(0,s.height/PTM_RATIO), b2Vec2(s.width/PTM_RATIO,s.height/PTM_RATIO));
	groundBody->CreateFixture(&groundBox,0);
	
	// left
	groundBox.Set(b2Vec2(0,s.height/PTM_RATIO), b2Vec2(0,0));
	groundBody->CreateFixture(&groundBox,0);
	
	// right
	groundBox.Set(b2Vec2(s.width/PTM_RATIO,s.height/PTM_RATIO), b2Vec2(s.width/PTM_RATIO,0));
	groundBody->CreateFixture(&groundBox,0);
}

-(void) draw
{
	//
	// IMPORTANT:
	// This is only for debug purposes
	// It is recommend to disable it
	//
	[super draw];
	
	ccGLEnableVertexAttribs( kCCVertexAttribFlag_Position );
	
	kmGLPushMatrix();
	
	world->DrawDebugData();
	
	kmGLPopMatrix();
}

- (void) update:(ccTime)dt
{
    [self updateGlobalPositions];
        
    crossHair.position = crossHairPosition;
    
    if([[GameManager sharedManager] getGameEnabledState]){
        
        if([LevelManager sharedManager].enemyArray.count==0){
            NSLog(@"no more enemies left");
            [[NSNotificationCenter defaultCenter] postNotificationName:kNO_ENEMY_LEFT object:nil];
        }
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
        
        //centerX = eyeX = clampf(centerX, 0.0f, ground.contentSize.width - winSize.width);
        //centerY = eyeY = clampf(centerY, 0.0f, ground.contentSize.height - winSize.height);
        
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
        
        [[GameManager sharedManager] setGameState:NO];
        
        [self unscheduleAllSelectors];
        [self unscheduleUpdate];
        
        CCLayerColor *color = [[CCLayerColor alloc] initWithColor:ccc4(0, 0, 0, 150) width:2000 height:2000];
        [self addChild:color];
        
        id action1 = [CCFadeIn actionWithDuration:.5];
        id call = [CCCallFunc actionWithTarget:self selector:@selector(gameEnded)];
        id delay = [CCDelayTime actionWithDuration:1];
        CCSequence* sequence = [CCSequence actions:action1,delay,call, nil];
        [color runAction:sequence];
        
        // CLEAR ALL
        
    }
    
    if ([notification.name isEqualToString:kNO_ENEMY_LEFT]) {
        NSLog(@"GAME ENDED");
    }
    
    if ([notification.name isEqualToString:kGENERATE_DROP])
    {
        if ([[notification.userInfo valueForKey:@"dropType"] isEqualToString:@"health"])
        {
            
            float xVal = [[notification.userInfo valueForKey:@"locationX"] floatValue];
            float yVal = [[notification.userInfo valueForKey:@"locationY"] floatValue];
            CGPoint point = ccp(xVal, yVal);
            HealthPack *health = [[HealthPack alloc] initAtPoint:point];
            [ground addChild:health z:2];
            
        }
    }
}

- (void) gameEnded
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kHEALTH_ADD object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kHEALTH_DROP object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kHEALTH_ZERO object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNO_ENEMY_LEFT object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kGENERATE_DROP object:nil];
    
    [player killCreature];
    [ground removeChild:player];
    
    for (int i=0; i<[LevelManager sharedManager].enemyArray.count; i++) {
        [(Enemy*)[[LevelManager sharedManager].enemyArray objectAtIndex:i] killCreature];
        [[[LevelManager sharedManager].enemyArray objectAtIndex:i] removeFromParentAndCleanup:YES];
    }
    
    
    for (int i=0; i<[LevelManager sharedManager].bulletArray.count; i++) {
        [[[LevelManager sharedManager].bulletArray objectAtIndex:i] removeFromParentAndCleanup:YES];
    }
    
    for (int i=0; i<[LevelManager sharedManager].enemyBulletArray.count; i++) {
        [[[LevelManager sharedManager].enemyBulletArray objectAtIndex:i] removeFromParentAndCleanup:YES];
    }
    
    for (int i=0; i<[LevelManager sharedManager].healthArray.count; i++) {
        [[[LevelManager sharedManager].healthArray objectAtIndex:i] removeFromParentAndCleanup:YES];
    }
    
    for (int i=0; i<[LevelManager sharedManager].dropArray.count; i++) {
        [[[LevelManager sharedManager].dropArray objectAtIndex:i] removeFromParentAndCleanup:YES];
    }
    
    [[LevelManager sharedManager] cleanUp];
    
    [[CCDirector sharedDirector] replaceScene:[[SceneManager sharedSceneManager] sceneWithID:2]];
}

- (void) dealloc
{
    delete world;
	world = NULL;
	
	delete m_debugDraw;
	m_debugDraw = NULL;
    
    NSLog(@"game layer dealloc called");
    [playerMovement removeAllObjects];
    playerMovement = nil;
    
    [self removeAllChildrenWithCleanup:YES];
    [super dealloc];
}

////

- (void)addBoxBodyForSprite:(CCSprite *)sprite {
    
    b2BodyDef spriteBodyDef;
    spriteBodyDef.type = b2_dynamicBody;
    spriteBodyDef.position.Set(sprite.position.x/PTM_RATIO, sprite.position.y/PTM_RATIO);
    spriteBodyDef.userData = sprite;
    b2Body *spriteBody = world->CreateBody(&spriteBodyDef);
    
    b2PolygonShape bodyBox;
    bodyBox.SetAsBox(.40f, .60f);
    
    b2FixtureDef spriteShapeDef;
    spriteShapeDef.shape = &bodyBox;
    spriteShapeDef.density = 10.0;
    spriteShapeDef.isSensor = false;
    
    spriteBody->CreateFixture(&spriteShapeDef);
}



@end
