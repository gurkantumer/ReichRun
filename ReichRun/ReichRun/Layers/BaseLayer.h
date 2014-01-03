//
//  BaseLayer.h
//  ReichRun
//
//  Created by Gurkan Tumer on 30/12/13.
//  Copyright (c) 2013 Studio Nord. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface BaseLayer : CCLayer
{
    CGPoint crossHairPosition;
    CGPoint mousePosition;
}

@property (nonatomic) CGPoint crossHairPosition;
@property (nonatomic) CGPoint mousePosition;

+(CCScene *) scene;

- (void) updateGlobalPositions;
- (void) addLabelWithText:(NSString *)str atPoint:(CGPoint)point;

@end
