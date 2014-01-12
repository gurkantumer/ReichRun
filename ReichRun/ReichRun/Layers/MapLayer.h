//
//  MapLayer.h
//  ReichRun
//
//  Created by Gurkan Tumer on 07/01/14.
//  Copyright (c) 2014 Studio Nord. All rights reserved.
//

#import "BaseLayer.h"

@interface MapLayer : BaseLayer
{
    CCSprite *mapBg;
}

@property (nonatomic, retain) CCSprite *mapBg;

@end