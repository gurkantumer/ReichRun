//
//  GameManager.m
//  ReichRun
//
//  Created by Gurkan Tumer on 30/12/13.
//  Copyright (c) 2013 Studio Nord. All rights reserved.
//

#import "GameManager.h"

@implementation GameManager

static GameManager *manager = nil;

- (id)init
{
    if ((self = [super init]))
    {
        isKeyboardEnabled = NO;
    }
    return self;
}

+ (GameManager *)sharedManager
{
    @synchronized (self)
    {
        if (manager == nil)
        {
            manager = [[GameManager alloc] init];
        }
        return manager;
    }
}


- (BOOL) getKeyboardEnabledState
{
    return isKeyboardEnabled;
}

- (void) setKeyboardEnabledState:(BOOL)state
{
    isKeyboardEnabled = state;
}

@end
