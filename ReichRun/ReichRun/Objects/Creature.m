//
//  Creature.m
//  ReichRun
//
//  Created by Gurkan Tumer on 31/12/13.
//  Copyright (c) 2013 Studio Nord. All rights reserved.
//

#import "Creature.h"
#import "LevelManager.h"

@implementation Creature

@synthesize health;
@synthesize ground;

- (id)initWithGround:(CCSprite*)gr {
    self = [super initWithFile:@"char.png"];
    if( self != nil )
    {
        ground = gr;        
    }
    return self;
}

- (void) prepare
{
    health = 100;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationHandler:) name:kHEALTH_ADD object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationHandler:) name:kHEALTH_DROP object:nil];
}

- (void) notificationHandler:(NSNotification*)notify
{
    NSLog(@"notification : %@",notify.name);
}

- (void) fireBullet:(CGPoint)point atLayer:(BaseLayer*)lyr
{
    // Create a projectile and put it at the player's location
    CCSprite *bullet = [CCSprite spriteWithFile:@"bullet.png"];
    bullet.position = self.position;
    // bu değişecek
    [ground addChild:bullet];
    
    //NSLog(@"self kind %@", [self class]);
    if([self isKindOfClass:[Player class]]){
        [[LevelManager sharedManager].bulletArray addObject:bullet];
    }
    if([self isKindOfClass:[Enemy class]]) {
        [[LevelManager sharedManager].enemyBulletArray addObject:bullet];
    }
    int realX;
    
    CGPoint diff = ccpSub(point, self.position);
    if (diff.x > 0)
    {
        realX = (ground.contentSize.width) + (bullet.contentSize.width/2);
    } else {
        realX = -(ground.contentSize.width) - (bullet.contentSize.width/2);
    }
    float ratio = (float) diff.y / (float) diff.x;
    int realY = ((realX - bullet.position.x) * ratio) + bullet.position.y;
    CGPoint realDest = ccp(realX, realY);
    
    // Determine the length of how far we're shooting
    int offRealX = realX - bullet.position.x;
    int offRealY = realY - bullet.position.y;
    float length = sqrtf((offRealX*offRealX) + (offRealY*offRealY));
    float velocity = 1000/1; // 480pixels/1sec
    float realMoveDuration = length/velocity;
    
    CGPoint difference = ccpSub(bullet.position, point);
    CGFloat rotationRadians = ccpToAngle(difference);
    CGFloat rotationDegrees = -CC_RADIANS_TO_DEGREES(rotationRadians);
    //rotationDegrees += 90.0f;
    CGFloat rotateByDegrees = rotationDegrees - bullet.rotation;
    
    bullet.rotation = rotateByDegrees;
    
    // Move projectile to actual endpoint
    id actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(bulletMoveFinished:)];
    [bullet runAction:
    [CCSequence actionOne:[CCMoveTo actionWithDuration:realMoveDuration position:realDest] two: actionMoveDone]];
}

- (void) bulletMoveFinished:(id)sender
{
    [ground removeChild:sender cleanup:YES];
    
    if([self isKindOfClass:[Player class]]){
        [[LevelManager sharedManager].bulletArray removeObject:sender];
    }
    if([self isKindOfClass:[Enemy class]]) {
        [[LevelManager sharedManager].enemyBulletArray removeObject:sender];
    }
    
}

- (void) updateHealth:(float)hValue
{
    health += hValue;
    
    if (health >100)
    {
        health = 100;
    }
    
    if (health<=0)
    {
        health = 0;
        
        if ([self isKindOfClass:[Player class]]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kHEALTH_ZERO object:nil];
        }
        
        if ([self isKindOfClass:[Enemy class]])
        {
            [[LevelManager sharedManager].enemyArray removeObject:self];
            [self killCreature];
        }
    }
    
    NSLog(@"HEALTH : %f",health);
}

- (void) killCreature
{
    // death animation
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kHEALTH_ADD object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kHEALTH_DROP object:nil];
    [self removeFromParentAndCleanup:YES];
    
}

- (void) updateTargetPosition:(CGPoint)tPosition
{
    targetPosition = tPosition;
}

- (void)dealloc {
    
    [self removeAllChildrenWithCleanup:YES];
    [super dealloc];
}

@end
