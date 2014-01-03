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
#import "HealthPack.h"
#import "Ground.h"

@interface GameLayer : BaseLayer
{
    NSMutableArray *playerMovement;
    BOOL isSpacePressed;
    
    Player *player;
    CCSprite *crossHair;
    Ground *ground;
}

@property (nonatomic, retain) NSMutableArray *playerMovement;
@property (nonatomic, retain) Player *player;
@property (nonatomic, retain) Ground *ground;
@property (nonatomic, retain) CCSprite *crossHair;

- (void) notificationHandler:(NSNotification*)notification;

@end
