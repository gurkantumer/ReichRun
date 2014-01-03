//
//  LevelManager.m
//  ReichRun
//
//  Created by Gurkan Tumer on 30/12/13.
//  Copyright (c) 2013 Studio Nord. All rights reserved.
//

#import "LevelManager.h"

@implementation LevelManager

static LevelManager *sharedManager = nil;

@synthesize enemyArray;
@synthesize healthArray;
@synthesize dropArray;
@synthesize bulletArray;
@synthesize enemyBulletArray;

@synthesize gameAreaSize;
@synthesize healthCount;
@synthesize enemyCount;
@synthesize currentLevel;
@synthesize healthValue;

- (id)init
{
    if ((self = [super init]))
    {
        enemyArray = [[NSMutableArray alloc] init];
        healthArray = [[NSMutableArray alloc] init];
        dropArray = [[NSMutableArray alloc] init];
        bulletArray = [[NSMutableArray alloc] init];
        enemyBulletArray = [[NSMutableArray alloc] init];
        
        gameAreaSize = CGSizeMake(2000, 1600);
        healthCount = 5;
        enemyCount = 10;
        currentLevel = 1;
        
        healthValue = 10;
    }
    return self;
}

+ (LevelManager *)sharedManager
{
    @synchronized (self)
    {
        if (sharedManager == nil)
        {
            sharedManager = [[LevelManager alloc] init];
        }
        return sharedManager;
    }
}

- (void) cleanUp
{
    [enemyArray removeAllObjects];
    [healthArray removeAllObjects];
    [dropArray removeAllObjects];
    [bulletArray removeAllObjects];
    [enemyBulletArray removeAllObjects];
}

@end
