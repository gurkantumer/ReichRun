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
        isGamePlayable = YES;
        isMouseEnabled = NO;
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

#pragma mark GAME STATES
// keyboard state
- (BOOL) getKeyboardEnabledState
{
    return isKeyboardEnabled;
}

- (void) setKeyboardEnabledState:(BOOL)state
{
    isKeyboardEnabled = state;
}
// mouse state
- (BOOL) getMouseEnabledState
{
    return isMouseEnabled;
}

- (void) setMouseEnabledState:(BOOL)state
{
    isMouseEnabled = state;
}
// game play state
- (BOOL) getGameEnabledState
{
    return isGamePlayable;
}

- (void) setGameEnabledState:(BOOL)state
{
    isGamePlayable = state;
}

- (BOOL) getGameState
{
    return isGameEnded;
}

- (void) setGameState:(BOOL)state
{
    isGameEnded = state;
}

/// setup


- (int) getUserHealthCount
{
    return 3;
}

- (int) getEnemyCount
{
    return 10;
}

- (int) getCurrentLevel
{
    return 1;
}

- (int) getUserHealthValue
{
    return 10;
}

- (int) getDropRate
{
    return 300;
}


- (int) getEnemyHealth
{
    return 80;
}

- (void) dealloc
{
    [super dealloc];
}

@end
