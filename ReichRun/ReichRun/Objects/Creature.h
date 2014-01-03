//
//  Creature.h
//  ReichRun
//
//  Created by Gurkan Tumer on 31/12/13.
//  Copyright (c) 2013 Studio Nord. All rights reserved.
//

#import "BaseObject.h"
#import "BaseLayer.h"

@interface Creature : BaseObject
{
    CCSprite *ground;
    CGPoint targetPosition;
    CGFloat health;
}

@property (nonatomic) CGFloat health;
@property (nonatomic, retain) CCSprite *ground;

- (id)initWithGround:(CCSprite*)gr;
- (void) prepare;
- (void) updateTargetPosition:(CGPoint)tPosition;
- (void) notificationHandler:(NSNotification*)notify;

// game related actions

- (void) fireBullet:(CGPoint)point atLayer:(BaseLayer*)lyr;
- (void) bulletMoveFinished:(id)sender;
- (void) updateHealth:(float)hValue;

@end
