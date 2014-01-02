//
//  HealthPack.m
//  ReichRun
//
//  Created by Gurkan Tumer on 30/12/13.
//  Copyright (c) 2013 Studio Nord. All rights reserved.
//

#import "HealthPack.h"
#import "LevelManager.h"

@implementation HealthPack

- (id)init {
    self = [super initWithFile:@"health.png"];
    if( self != nil ) {
        velocityX = 0.0;
        velocityY = 0.0;
        [self setPosition:CGPointMake(arc4random() % (int) [LevelManager sharedManager].gameAreaSize.width, arc4random() % (int)[LevelManager sharedManager].gameAreaSize.height)];
        
        [[[LevelManager sharedManager] healthArray] addObject:self];
    }
    return self;
}

- (void) moveToPlayer
{
    float dx = self.position.x - targetPosition.x;
    float dy = self.position.y - targetPosition.y;
    self.position = ccp(self.position.x - dx / [self maxSpeed], self.position.y - dy / [self maxSpeed]);
    
    CGFloat distanceApart = ccpDistance(self.position, targetPosition);
    if (distanceApart<10)
    {
        NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
        [userInfo setValue:[NSString stringWithFormat:@"%f",targetPosition.x] forKey:@"locationX"];
        [userInfo setValue:[NSString stringWithFormat:@"%f",targetPosition.y] forKey:@"locationY"];
        [[NSNotificationCenter defaultCenter] postNotificationName:kHEALTH_ADD object:nil userInfo:userInfo];
        [[[LevelManager sharedManager] healthArray] removeObject:self];
        [self removeFromParentAndCleanup:YES];
    }
}

- (CGFloat) maxSpeed
{
    return 3.0;
}

- (void) updateTargetPosition:(CGPoint)tPosition
{
    targetPosition = tPosition;
}

@end
