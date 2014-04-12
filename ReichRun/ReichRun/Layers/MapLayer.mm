//
//  MapLayer.m
//  ReichRun
//
//  Created by Gurkan Tumer on 07/01/14.
//  Copyright (c) 2014 Studio Nord. All rights reserved.
//

#import "MapLayer.h"

@implementation MapLayer

@synthesize mapBg;

-(id) init
{
	if( (self=[super init]) ) {
        
        self.contentSize = [[CCDirector sharedDirector] winSize];
		mapBg = [CCSprite spriteWithFile:@"map.jpg"];
        [mapBg.texture setAntiAliasTexParameters];
        [mapBg setScaleX: ((100000)/mapBg.contentSize.width)/100];
        [mapBg setScaleY: ((100000)/mapBg.contentSize.width)/100];
        [mapBg setPosition:CGPointMake(self.contentSize.width/2, self.contentSize.height/2)];
        [mapBg setOpacity:0.0];
        [self addChild:mapBg];
        
        [self animateMap];
	}
	return self;
}

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
    MapLayer *layer = [MapLayer node];
	
	[scene addChild: layer];
	return scene;
}

- (void) animateMap
{
    [self setMouseEnabled:YES];
    
    id delay = [CCDelayTime actionWithDuration:2];
    id action1 = [CCFadeIn actionWithDuration:1.0]; // fading in
//    id action2 = [CCFadeOut actionWithDuration:1.0]; //fading out
//    id call = [CCCallFunc actionWithTarget:self selector:@selector(animateLogoEnded)];
    CCSequence* sequence = [CCSequence actions:delay,action1, nil];
    
    [mapBg runAction:sequence];
    
}

-(BOOL) ccMouseDown:(NSEvent *)event
{
    [self setKeyboardEnabled:NO];
    [self setMouseEnabled:NO];
    
    [[[CCDirector sharedDirector] eventDispatcher] removeMouseDelegate:self];
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[[SceneManager sharedSceneManager] sceneWithID:3] withColor:ccBLACK]];
    return YES;
}


- (void)windowDidResize:(NSNotification *)notification
{
    //self.contentSize = [[CCDirector sharedDirector] winSize];
    [mapBg setPosition:CGPointMake(self.contentSize.width/2, self.contentSize.height/2)];
}

- (void)dealloc
{
    NSLog(@"logolayer dealloc called");
    [self removeAllChildrenWithCleanup:YES];
    [super dealloc];
}

@end
