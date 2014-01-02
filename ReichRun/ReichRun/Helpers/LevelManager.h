//
//  LevelManager.h
//  ReichRun
//
//  Created by Gurkan Tumer on 30/12/13.
//  Copyright (c) 2013 Studio Nord. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Enemy.h"
#import "Player.h"

@interface LevelManager : NSObject
{
    NSMutableArray *enemyArray;
    NSMutableArray *healthArray;
    NSMutableArray *dropArray;
    NSMutableArray *bulletArray;
    NSMutableArray *enemyBulletArray;
    
    CGSize gameAreaSize;
    int healthCount;
    int enemyCount;
    
    int currentLevel;
    
    float healthValue;
}

@property (nonatomic, strong) NSMutableArray *enemyArray;
@property (nonatomic, strong) NSMutableArray *healthArray;
@property (nonatomic, strong) NSMutableArray *dropArray;
@property (nonatomic, strong) NSMutableArray *bulletArray;
@property (nonatomic, strong) NSMutableArray *enemyBulletArray;

@property (nonatomic) CGSize gameAreaSize;
@property (nonatomic) int healthCount;
@property (nonatomic) int enemyCount;
@property (nonatomic) int currentLevel;
@property (nonatomic) float healthValue;

// STATIC FUNCTIONS
+ (LevelManager *) sharedManager;

@end