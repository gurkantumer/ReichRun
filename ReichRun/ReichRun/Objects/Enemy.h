//
//  Enemy.h
//  ReichRun
//
//  Created by Gurkan Tumer on 30/12/13.
//  Copyright (c) 2013 Studio Nord. All rights reserved.
//

#import "Creature.h"

@interface Enemy : Creature
{
    BOOL isIDLE;
    BOOL isSHOOT;
}

@property (nonatomic) BOOL isIDLE;
@property (nonatomic) BOOL isSHOOT;

- (void) setPositionGraphic:(NSMutableArray *)movementData;
- (void) setUpSchedule;
- (void) moveToPlayer;
- (void) moveIdle:(ccTime)dt;

@end
