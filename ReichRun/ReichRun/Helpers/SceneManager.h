//
//  SceneManager.h
//  ReichRun
//
//  Created by Gurkan Tumer on 30/12/13.
//  Copyright (c) 2013 Studio Nord. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface SceneManager : NSObject
{
    NSMutableArray *scenesArray;
}

@property (nonatomic, strong) NSMutableArray *scenesArray;

// STATIC FUNCTIONS
+ (SceneManager *) sharedSceneManager;
// PUBLIC FUNCTIONS
- (CCScene *)sceneWithID:(NSInteger)idNum;

// GETTER SETTER
- (NSMutableArray *) getSceneArray;

@end
