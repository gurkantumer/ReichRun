//
//  Enemy.m
//  ReichRun
//
//  Created by Gurkan Tumer on 30/12/13.
//  Copyright (c) 2013 Studio Nord. All rights reserved.
//

#import "Enemy.h"

@implementation Enemy
@synthesize velocityX;
@synthesize velocityY;
@synthesize health;

- (id)init {
    self = [super init];
    if( self != nil ) {
        velocityX = 0.0;
        velocityY = 0.0;
        isIDLE = YES;
    }
    return self;
}

- (void) setUpSchedule
{
    isIDLE = YES;
    [self schedule:@selector(moveIdle:)interval:1.0f/60.0f];
}

- (void) moveToPlayer
{
    float dx = self.position.x - targetPosition.x;
    float dy = self.position.y - targetPosition.y;
    self.position = ccp(self.position.x - dx / [self maxSpeed], self.position.y - dy / [self maxSpeed]);
}

- (void) moveIdle
{
    if (isIDLE) {
        NSLog(@"hello idle move");
    }
}

- (CGFloat) maxSpeed
{
    return 100.0;
}
- (CGFloat) friction
{
    return 0.8;
}
- (CGFloat) acceleration
{
    return 0.9;
}

- (void) updateTargetPosition:(CGPoint)tPosition
{
    targetPosition = tPosition;
}

- (void) setPositionGraphic:(NSMutableArray *)movementData
{
    //    NSLog(@"movementData : %@",[movementData description]);
}

- (void)dealloc {
    
    [self removeAllChildrenWithCleanup:YES];
    // Deallocations...
    [super dealloc];
}
@end
