//
//  AppDelegate.h
//  ReichRunTest
//
//  Created by Gurkan Tumer on 04/01/14.
//  Copyright Studio Nord 2014. All rights reserved.
//

#import "cocos2d.h"

@interface ReichRunTestAppDelegate : NSObject <NSApplicationDelegate>
{
	NSWindow	*window_;
	CCGLView	*glView_;
}

@property (assign) IBOutlet NSWindow	*window;
@property (assign) IBOutlet CCGLView	*glView;

- (IBAction)toggleFullScreen:(id)sender;

@end
