//
//  AppDelegate.m
//  ReichRun
//
//  Created by Gurkan Tumer on 29/12/13.
//  Copyright Studio Nord 2013. All rights reserved.
//

#import "AppDelegate.h"
#import "LogoLayer.h"
#import "Helpers/Config.h"

@implementation ReichRunAppDelegate
@synthesize window=window_, glView=glView_;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	CCDirectorMac *director = (CCDirectorMac*) [CCDirector sharedDirector];

	// enable FPS and SPF
	[director setDisplayStats:kTOGGLE_DEBUG];
	[director setView:glView_];

	[director setResizeMode:kCCDirectorResize_NoScale];
	
	// Enable "moving" mouse event. Default no.
	[window_ setAcceptsMouseMovedEvents:YES];
	
	[window_ center];
	
	[director runWithScene:[LogoLayer scene]];
    [director setFullScreen:kTOGGLE_FULLSCREEN];
}

- (BOOL) applicationShouldTerminateAfterLastWindowClosed: (NSApplication *) theApplication
{
	return YES;
}

- (void)dealloc
{
	[[CCDirector sharedDirector] end];
	[window_ release];
	[super dealloc];
}

#pragma mark AppDelegate - IBActions

- (IBAction)toggleFullScreen: (id)sender
{
	CCDirectorMac *director = (CCDirectorMac*) [CCDirector sharedDirector];
	[director setFullScreen: ! [director isFullScreen] ];
}

@end
