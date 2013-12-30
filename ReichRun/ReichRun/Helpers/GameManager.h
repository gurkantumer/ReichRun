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
}

+ (GameManager *) sharedManager;

// GET-SET
- (BOOL) getKeyboardEnabledState;
- (void) setKeyboardEnabledState:(BOOL)state;

@end
