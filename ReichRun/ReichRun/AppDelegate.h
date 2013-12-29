//
//  AppDelegate.h
//  ReichRun
//
//  Created by Gurkan Tumer on 29/12/13.
//  Copyright Studio Nord 2013. All rights reserved.
//

#import "cocos2d.h"

@interface ReichRunAppDelegate : NSObject <NSApplicationDelegate>
{
	NSWindow	*window_;
	CCGLView	*glView_;
}

@property (assign) IBOutlet NSWindow	*window;
@property (assign) IBOutlet CCGLView	*glView;

- (IBAction)toggleFullScreen:(id)sender;

@end
