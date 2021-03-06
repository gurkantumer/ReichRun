//
//  LogoLayer.m
//  ReichRun
//
//  Created by Gurkan Tumer on 30/12/13.
//  Copyright 2013 Studio Nord. All rights reserved.
//

#import "LogoLayer.h"

@implementation LogoLayer

@synthesize logoSprite;

-(id) init
{
	if( (self=[super init]) ) {
    
        self.contentSize = [[CCDirector sharedDirector] winSize];
		logoSprite = [CCSprite spriteWithFile:@"logo.png"];
        [logoSprite.texture setAntiAliasTexParameters];
        [logoSprite setPosition:CGPointMake(self.contentSize.width/2, self.contentSize.height/2)];
        [logoSprite setOpacity:0.0];
        [self addChild:logoSprite];
        
        [self animateLogo];
	}
	return self;
}

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
    LogoLayer *layer = [LogoLayer node];
	
	[scene addChild: layer];
	return scene;
}

- (void) animateLogo
{

    id delay = [CCDelayTime actionWithDuration:2];
    id action1 = [CCFadeIn actionWithDuration:1.0]; // fading in
    id action2 = [CCFadeOut actionWithDuration:1.0]; //fading out
    id call = [CCCallFunc actionWithTarget:self selector:@selector(animateLogoEnded)];
    CCSequence* sequence = [CCSequence actions:delay,action1, delay, action2, call, nil];

    [logoSprite runAction:sequence];
}

- (void)windowDidResize:(NSNotification *)notification
{
    //self.contentSize = [[CCDirector sharedDirector] winSize];
    [logoSprite setPosition:CGPointMake(self.contentSize.width/2, self.contentSize.height/2)];
}

- (void) animateLogoEnded
{
    NSLog(@"ended");
    [self setKeyboardEnabled:NO];
    [self setMouseEnabled:NO];
    
    [[[CCDirector sharedDirector] eventDispatcher] removeMouseDelegate:self];
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[[SceneManager sharedSceneManager] sceneWithID:1] withColor:ccBLACK]];
}

- (void)dealloc
{
    NSLog(@"logolayer dealloc called");
    [self removeAllChildrenWithCleanup:YES];
    [super dealloc];
}

@end
