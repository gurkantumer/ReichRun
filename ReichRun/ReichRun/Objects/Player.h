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
    
}

- (CGFloat) maxSpeed;
- (CGFloat) friction;
- (CGFloat) acceleration;
- (CGFloat) velocityX;
- (CGFloat) velocityY;

@end
