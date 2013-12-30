//
//  SceneManager.m
//  ReichRun
//
//  Created by Gurkan Tumer on 30/12/13.
//  Copyright (c) 2013 Studio Nord. All rights reserved.
//

#import "SceneManager.h"
#import "BaseLayer.h"

@implementation SceneManager

static SceneManager *sceneManager = nil;

@synthesize scenesArray;

- (id)init
{
    if ((self = [super init]))
    {
        scenesArray = [[NSMutableArray alloc] init];
        [scenesArray addObject:@"LogoLayer"];
        [scenesArray addObject:@"GameLayer"];
    }
    return self;
}

+ (SceneManager *)sharedSceneManager
{
    @synchronized (self)
    {
        if (sceneManager == nil)
        {
            sceneManager = [[SceneManager alloc] init];
        }
        return sceneManager;
    }
}

- (NSMutableArray *) getSceneArray
{
    return scenesArray;
}

- (BaseLayer *)sceneWithID:(NSInteger)idNum;
{
    NSLog(@"cal : idNum : %li" , (long)idNum);
    
    NSString *sceneName = [scenesArray objectAtIndex:idNum];
    Class sceneClass = NSClassFromString(sceneName);
    
    return (BaseLayer*)[sceneClass scene];
}

@end
