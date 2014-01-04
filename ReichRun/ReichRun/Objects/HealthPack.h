//
//  HealthPack.h
//  ReichRun
//
//  Created by Gurkan Tumer on 30/12/13.
//  Copyright (c) 2013 Studio Nord. All rights reserved.
//

#import "BaseObject.h"

@interface HealthPack : BaseObject
{
    CGPoint targetPosition;
}

- (id) initAtPoint:(CGPoint)point;
- (void) updateTargetPosition:(CGPoint)tPosition;
- (void) moveToPlayer;

@end
