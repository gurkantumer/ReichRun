//
//  Player.m
//  ReichRun
//
//  Created by Gurkan Tumer on 30/12/13.
//  Copyright (c) 2013 Studio Nord. All rights reserved.
//

#import "Player.h"

@implementation Player

- (id)init {
    self = [super init];
    if( self != nil ) {
    }
    return self;
}

- (CGFloat) maxSpeed
{
    return 5.0;
}
- (CGFloat) friction
{
    return 0.98;
}
- (CGFloat) acceleration
{
    return 0.5;
}
- (CGFloat) velocityX
{
    return 0.0;
}
- (CGFloat) velocityY
{
    return 0.0;
}

- (void)dealloc {
    // Deallocations...
    [super dealloc];
}
@end
