//
//  BaseLayer.m
//  ReichRun
//
//  Created by Gurkan Tumer on 30/12/13.
//  Copyright (c) 2013 Studio Nord. All rights reserved.
//

#import "BaseLayer.h"

@implementation BaseLayer

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
    BaseLayer *layer = [BaseLayer node];
	
	[scene addChild: layer];
	return scene;
}

-(id) init
{
	if( (self=[super init]) ) {
		[self setKeyboardEnabled:YES];
	}
	return self;
}

- (BOOL) ccKeyDown : (NSEvent*) event
{
    NSString *str_1 = [event characters];
    unichar ch = [str_1 characterAtIndex:0];
    NSLog(@"%hu",ch);
    return YES;
}

- (BOOL) ccKeyUp : (NSEvent*) event
{
    //NSString *str_1 = [KeyDownEvent characters];
    //unichar ch = [str_1 characterAtIndex:0];
    return YES;
}

@end
