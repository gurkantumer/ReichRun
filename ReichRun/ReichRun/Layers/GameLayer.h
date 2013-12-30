//
//  GameLayer.h
//  ReichRun
//
//  Created by Gurkan Tumer on 30/12/13.
//  Copyright (c) 2013 Studio Nord. All rights reserved.
//

#import "BaseLayer.h"
#import "Player.h"
#import "Enemy.h"

@interface GameLayer : BaseLayer
{
    NSMutableArray *playerMovement;
    BOOL isSpacePressed;
    
    NSMutableArray *enemyArray;
    
    Player *player;
    CCSprite *crossHair;
}

@property (nonatomic, retain) NSMutableArray *playerMovement;
@property (nonatomic, retain) NSMutableArray *enemyArray;
@property (nonatomic, retain) Player *player;
@property (nonatomic, retain) CCSprite *crossHair;

@end
