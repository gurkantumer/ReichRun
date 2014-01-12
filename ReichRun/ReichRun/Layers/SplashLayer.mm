//
//  SplashLayer.m
//  ReichRun
//
//  Created by Gurkan Tumer on 05/01/14.
//  Copyright (c) 2014 Studio Nord. All rights reserved.
//

#import "SplashLayer.h"

@implementation SplashLayer

@synthesize splashSprite;
@synthesize splashLogo;

-(id) init
{
	if( (self=[super init]) ) {
        
        self.contentSize = [[CCDirector sharedDirector] winSize];
		splashSprite = [CCSprite spriteWithFile:@"splashBg.jpg"];
        [splashSprite.texture setAntiAliasTexParameters];
        [splashSprite setScaleX: ((self.contentSize.width*100)/splashSprite.contentSize.width)/100];
        [splashSprite setScaleY: ((self.contentSize.width*100)/splashSprite.contentSize.width)/100];
        [splashSprite setPosition:CGPointMake(self.contentSize.width/2, self.contentSize.height/2)];
        [splashSprite setOpacity:0.0];
        [self addChild:splashSprite];
        
        splashLogo = [CCSprite spriteWithFile:@"splashLogo.png"];
        [splashLogo.texture setAntiAliasTexParameters];
        [splashLogo setPosition:CGPointMake(self.contentSize.width/2, self.contentSize.height/2)];
        [splashLogo setOpacity:0.0];
        [self addChild:splashLogo];
        
        [self animateSplash];
	}
	return self;
}

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
    SplashLayer *layer = [SplashLayer node];
	
	[scene addChild: layer];
	return scene;
}

- (void) animateSplash
{
    
    id delay = [CCDelayTime actionWithDuration:.5];
    id action1 = [CCFadeIn actionWithDuration:.5];
    id action2 = [CCFadeIn actionWithDuration:.3];
    id call = [CCCallFunc actionWithTarget:self selector:@selector(animateSplashEnded)];
    CCSequence* sequence1 = [CCSequence actions:delay,action1, call, nil];
    CCSequence* sequence2 = [CCSequence actions:delay,delay,action2, nil];
    
    [splashSprite runAction:sequence1];
    [splashLogo runAction:sequence2];
}

- (void)windowDidResize:(NSNotification *)notification
{
    //self.contentSize = [[CCDirector sharedDirector] winSize];
    [splashSprite setPosition:CGPointMake(self.contentSize.width/2, self.contentSize.height/2)];
}

- (void) animateSplashEnded
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"click to play" fontName:@"Helvetica" fontSize:34];
    label.position = ccp(winSize.width/2,120);
    [self addChild:label];
    
    [self setMouseEnabled:YES];
}

-(BOOL) ccMouseDown:(NSEvent *)event
{
    [self setKeyboardEnabled:NO];
    [self setMouseEnabled:NO];
    
    [[[CCDirector sharedDirector] eventDispatcher] removeMouseDelegate:self];
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[[SceneManager sharedSceneManager] sceneWithID:2] withColor:ccBLACK]];
    return YES;
}

- (void)dealloc
{
    NSLog(@"splash dealloc called");
    [self removeAllChildrenWithCleanup:YES];
    [super dealloc];
}

@end
