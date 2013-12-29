//
//  HelloWorldLayer.m
//  ReichRun
//
//  Created by Gurkan Tumer on 29/12/13.
//  Copyright Studio Nord 2013. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// HelloWorldLayer implementation
@implementation HelloWorldLayer

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
    HelloWorldLayer *layer = [HelloWorldLayer node];
	
	[scene addChild: layer];
	
	return scene;
}

-(id) init
{
	if( (self=[super init]) ) {
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Hello World" fontName:@"Marker Felt" fontSize:64];

		CGSize size = [[CCDirector sharedDirector] winSize];
	
		label.position =  ccp( size.width /2 , size.height/2 );
		
		[self addChild: label];
	}
	return self;
}

- (void) dealloc
{
	[super dealloc];
}
@end
