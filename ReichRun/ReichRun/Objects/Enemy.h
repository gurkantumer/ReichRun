//
//  Enemy.h
//  ReichRun
//
//  Created by Gurkan Tumer on 30/12/13.
//  Copyright (c) 2013 Studio Nord. All rights reserved.
//

#import "CCSprite.h"

@interface Enemy : CCSprite
{
    CGFloat velocityX;
    CGFloat velocityY;
    
    CGFloat health;
    
    CGPoint targetPosition;
}

@property (nonatomic) CGFloat velocityX;
@property (nonatomic) CGFloat velocityY;
@property (nonatomic) CGFloat health;

- (void) setPositionGraphic:(NSMutableArray *)movementData;
- (void) updateTargetPosition:(CGPoint)tPosition;
- (void) move;

// static values
- (CGFloat) maxSpeed;
- (CGFloat) friction;
- (CGFloat) acceleration;

@end
