//
//  SplashLayer.h
//  ReichRun
//
//  Created by Gurkan Tumer on 05/01/14.
//  Copyright (c) 2014 Studio Nord. All rights reserved.
//

#import "BaseLayer.h"

@interface SplashLayer : BaseLayer
{
    CCSprite *splashSprite;
    CCSprite *splashLogo;
}

@property (nonatomic, retain) CCSprite *splashSprite;
@property (nonatomic, retain) CCSprite *splashLogo;

@end
