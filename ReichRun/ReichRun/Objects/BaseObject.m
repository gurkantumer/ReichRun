//
//  BaseObject.m
//  ReichRun
//
//  Created by Gurkan Tumer on 30/12/13.
//  Copyright (c) 2013 Studio Nord. All rights reserved.
//

#import "BaseObject.h"

@implementation BaseObject

@synthesize velocityX;
@synthesize velocityY;

- (id)init {
    self = [super init];
    if( self != nil ) {
        velocityX = 0.0;
        velocityY = 0.0;
    }
    return self;
}

- (void) updatePosition:(NSMutableArray *)playerMovement
{
    
}

- (CGFloat) maxSpeed
{
    return 3.0;
}
- (CGFloat) friction
{
    return 0.8;
}
- (CGFloat) acceleration
{
    return 0.9;
}

- (void)dealloc {
    
    [self removeAllChildrenWithCleanup:YES];
    // Deallocations...
    [super dealloc];
}

@end
