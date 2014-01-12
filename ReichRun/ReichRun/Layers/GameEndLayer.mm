//
//  GameEndLayer.m
//  ReichRun
//
//  Created by Gurkan Tumer on 02/01/14.
//  Copyright (c) 2014 Studio Nord. All rights reserved.
//

#import "GameEndLayer.h"

@implementation GameEndLayer

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
    GameEndLayer *layer = [GameEndLayer node];
    
	[scene addChild: layer];
    return scene;
}

-(id) init
{
	if( (self=[super init]) )
    {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"click to retry" fontName:@"Helvetica" fontSize:24];
        label.position = ccp(winSize.width/2,winSize.height/2);
        [self addChild:label];
        
        [self setMouseEnabled:YES];
    }
    return self;
}

-(BOOL) ccMouseDown:(NSEvent *)event
{
    NSLog(@"hello");
    [self setMouseEnabled:NO];
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[[SceneManager sharedSceneManager] sceneWithID:2] withColor:ccBLACK]];
    return YES;
}

- (void) dealloc
{
    NSLog(@"gameend dealloc");
    [self removeAllChildrenWithCleanup:YES];
    [super dealloc];
}


@end
