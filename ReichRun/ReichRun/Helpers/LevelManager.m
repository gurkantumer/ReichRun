//
//  LevelManager.m
//  ReichRun
//
//  Created by Gurkan Tumer on 30/12/13.
//  Copyright (c) 2013 Studio Nord. All rights reserved.
//

#import "LevelManager.h"
#import "GameManager.h"

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
        
        healthValue = 30;
        dropRate = 300;
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

- (void) generateDropAtPoint:(CGPoint)point
{
    // DROP GENERATION
    
    if ([[GameManager sharedManager] getGameState])
    {
        NSInteger randomValue = arc4random() % 1000;
        NSLog(@"random : %li",(long)randomValue);
        
        if (randomValue <= dropRate)
        {
            NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
            [userInfo setValue:[NSString stringWithFormat:@"%f",point.x] forKey:@"locationX"];
            [userInfo setValue:[NSString stringWithFormat:@"%f",point.y] forKey:@"locationY"];
            [userInfo setValue:@"health" forKey:@"dropType"];
            [[NSNotificationCenter defaultCenter] postNotificationName:kGENERATE_DROP object:nil userInfo:userInfo];
        }
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
