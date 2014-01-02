//
//  BaseObject.h
//  ReichRun
//
//  Created by Gurkan Tumer on 30/12/13.
//  Copyright (c) 2013 Studio Nord. All rights reserved.
//

#import "CCSprite.h"

@interface BaseObject : CCSprite
{
    CGFloat velocityX;
    CGFloat velocityY;
}

@property (nonatomic) CGFloat velocityX;
@property (nonatomic) CGFloat velocityY;

// static values
- (CGFloat) maxSpeed;
- (CGFloat) friction;
- (CGFloat) acceleration;
- (void) updatePosition:(NSMutableArray *)playerMovement;
@end
