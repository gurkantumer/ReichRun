//
//  Enemy.m
//  ReichRun
//
//  Created by Gurkan Tumer on 30/12/13.
//  Copyright (c) 2013 Studio Nord. All rights reserved.
//

#import "Enemy.h"
#import "LevelManager.h"

@implementation Enemy

@synthesize isIDLE;
@synthesize isSHOOT;

- (id)initWithGround:(CCSprite*)gr
{
    self = [super initWithFile:@"enemy.png"];
    if( self != nil )
    {
        ground = gr;
        
        [self prepare];
        
        isIDLE = YES;
        isSHOOT = NO;
        
        [self setPosition:CGPointMake(arc4random() % (int) [LevelManager sharedManager].gameAreaSize.width, arc4random() % (int)[LevelManager sharedManager].gameAreaSize.height)];
        [[LevelManager sharedManager].enemyArray addObject:self];
        [self setUpSchedule];
    }
    return self;
}

- (void) setUpSchedule
{
    targetPosition = self.position;
    isIDLE = YES;
    [self schedule:@selector(decisionMaking:) interval:1.0f];
    [self schedule:@selector(moveIdle:)interval:1.0f/60.0f];
}

- (void) moveToPlayer
{
    isIDLE = NO;
    
    if (!isSHOOT) {
        float dx = self.position.x - targetPosition.x;
        float dy = self.position.y - targetPosition.y;
        CGFloat distanceApart = ccpDistance(self.position, targetPosition);
        if (distanceApart>100)
        {
            self.position = ccp(self.position.x - dx / ([self maxSpeed]*.4), self.position.y - dy / ([self maxSpeed]*.4));
        }
    }
}

- (void) decisionMaking:(ccTime)dt
{
    int num = arc4random() % 3;
    isSHOOT = NO;
    
    if (isIDLE)
    {
        if (num == 0) {
           // NSLog(@"NaN");
        }
        if (num == 1) {
           // NSLog(@"Walk around");
            CGSize winSize = [[CCDirector sharedDirector] winSize];
            targetPosition = ccp(arc4random() % (int) winSize.width, arc4random() % (int) winSize.height);
        }
        
    }else{
        if (num == 2) {
           // NSLog(@"SHOOT THAT MOTHERFUCKER");
            isSHOOT = YES;
            [self fireBullet:targetPosition atLayer:(BaseLayer*)ground];
        }
    }
}

- (void) moveIdle:(ccTime)dt
{
    if (isIDLE)
    {
        float dx = self.position.x - targetPosition.x;
        float dy = self.position.y - targetPosition.y;
        self.position = ccp(self.position.x - dx / ([self maxSpeed]), self.position.y - dy / ([self maxSpeed]));
    }
}

- (void) setPositionGraphic:(NSMutableArray *)movementData
{
    //    NSLog(@"movementData : %@",[movementData description]);
}

// custom setup
- (CGFloat) maxSpeed
{
    return 5.0;
}

- (void)dealloc {
    
    [self removeAllChildrenWithCleanup:YES];
    // Deallocations...
    [super dealloc];
}
@end
