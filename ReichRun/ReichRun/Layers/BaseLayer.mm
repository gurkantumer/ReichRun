//
//  BaseLayer.m
//  ReichRun
//
//  Created by Gurkan Tumer on 30/12/13.
//  Copyright (c) 2013 Studio Nord. All rights reserved.
//

#import "BaseLayer.h"
#import "LevelManager.h"

@implementation BaseLayer

@synthesize mousePosition;
@synthesize crossHairPosition;

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
    BaseLayer *layer = [BaseLayer node];
	
	[scene addChild: layer];
	return scene;
}

-(id) init
{
	if( (self=[super init]) )
    {
		[self setKeyboardEnabled:YES];
        [self setMouseEnabled:YES];
    }
	return self;
}

- (void) addLabelWithText:(NSString *)str atPoint:(CGPoint)point
{
    CCLabelTTF *label = [CCLabelTTF labelWithString:str fontName:@"Helvetica" fontSize:24];
    label.position = point;
    [self addChild:label];
    
    id action1 = [CCMoveTo actionWithDuration:.5 position:ccp(point.x,point.y+50)]; // fading in
    id action2 = [CCFadeOut actionWithDuration:.3]; //fading out
    id call = [CCCallFunc actionWithTarget:self selector:@selector(animateLabelEnded:)];
    CCSequence* sequence = [CCSequence actions:action1, action2, call, nil];
    
    [label runAction:sequence];
}

- (void) animateLabelEnded:(id)sender
{
    //[sender removeFromParentAndCleanup:YES];
}

- (void) updateGlobalPositions
{
    float centerX, centerY, centerZ;
    [self.camera centerX:&centerX centerY:&centerY centerZ:&centerZ];
    
    CGPoint cameraPoint = CGPointMake(centerX, centerY);
    crossHairPosition = CGPointMake(mousePosition.x+cameraPoint.x, mousePosition.y+cameraPoint.y);
}

- (BOOL) ccKeyDown : (NSEvent*) event
{
    return YES;
}

- (BOOL) ccKeyUp : (NSEvent*) event
{
    return YES;
}

- (BOOL) ccMouseMoved:(NSEvent *)event
{
    return YES;
}

- (BOOL) ccMouseDown:(NSEvent *)event
{
    return YES;
}

- (void) dealloc
{
    NSLog(@"dealloc called");
    [self removeAllChildrenWithCleanup:YES];
    [super dealloc];
}

@end
