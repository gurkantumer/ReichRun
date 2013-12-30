//
//  GameLayer.h
//  ReichRun
//
//  Created by Gurkan Tumer on 30/12/13.
//  Copyright (c) 2013 Studio Nord. All rights reserved.
//

#import "BaseLayer.h"

@interface GameLayer : BaseLayer
{
    NSMutableArray *playerMovement;
    BOOL isSpacePressed;
}

@property (nonatomic, retain) NSMutableArray *playerMovement;

@end
