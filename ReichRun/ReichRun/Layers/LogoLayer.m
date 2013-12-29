//
//  LogoLayer.m
//  ReichRun
//
//  Created by Gurkan Tumer on 30/12/13.
//  Copyright 2013 Studio Nord. All rights reserved.
//

#import "LogoLayer.h"


@implementation LogoLayer

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
    LogoLayer *layer = [LogoLayer node];
	
	[scene addChild: layer];
	return scene;
}

-(id) init
{
	if( (self=[super init]) ) {
		
	}
	return self;
}

- (void) dealloc
{
	[super dealloc];
}
@end
