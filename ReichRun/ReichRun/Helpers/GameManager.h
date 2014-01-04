//
//  GameManager.h
//  ReichRun
//
//  Created by Gurkan Tumer on 30/12/13.
//  Copyright (c) 2013 Studio Nord. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameManager : NSObject
{
    BOOL isKeyboardEnabled;
    BOOL isMouseEnabled;
    BOOL isGamePlayable;
    BOOL isGameEnded;
}

+ (GameManager *) sharedManager;

// GET-SET
- (BOOL) getKeyboardEnabledState;
- (void) setKeyboardEnabledState:(BOOL)state;

- (BOOL) getMouseEnabledState;
- (void) setMouseEnabledState:(BOOL)state;

- (BOOL) getGameEnabledState;
- (void) setGameEnabledState:(BOOL)state;

- (BOOL) getGameState;
- (void) setGameState:(BOOL)state;

@end
