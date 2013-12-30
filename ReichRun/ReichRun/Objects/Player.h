//
//  Player.h
//  ReichRun
//
//  Created by Gurkan Tumer on 30/12/13.
//  Copyright (c) 2013 Studio Nord. All rights reserved.
//

#import "CCSprite.h"

@interface Player : CCSprite
{
    CGFloat velocityX;
    CGFloat velocityY;
}

@property (nonatomic) CGFloat velocityX;
@property (nonatomic) CGFloat velocityY;

- (void) setPositionGraphic:(NSMutableArray *)movementData;

// static values
- (CGFloat) maxSpeed;
- (CGFloat) friction;
- (CGFloat) acceleration;

@end
