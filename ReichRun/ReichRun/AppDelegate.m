//
//  AppDelegate.m
//  ReichRun
//
//  Created by Gurkan Tumer on 29/12/13.
//  Copyright Studio Nord 2013. All rights reserved.
//

#import "AppDelegate.h"
#import "LogoLayer.h"

@implementation ReichRunAppDelegate
@synthesize window=window_, glView=glView_;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    int width = 600;//[[NSScreen mainScreen] frame].size.width-100;
    int height = 400;//[[NSScreen mainScreen] frame].size.height-60;
    
    [window_ setFrame:NSMakeRect(0, 0, width, height) display:YES];
    
    CCDirectorMac *director = (CCDirectorMac*) [CCDirector sharedDirector];
    
	[director setDisplayStats:kTOGGLE_DEBUG];
    [glView_ setFrame:NSMakeRect(0, 0, width, height)];
    [director setView:glView_];
    
	[director setResizeMode:kCCDirectorResize_NoScale];
	
	[window_ setAcceptsMouseMovedEvents:YES];
	
	[window_ center];
	
    [director runWithScene:[[SceneManager sharedSceneManager] sceneWithID:0]];
    //[director setFullScreen:kTOGGLE_FULLSCREEN];
    
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
	//CCDirectorMac *director = (CCDirectorMac*) [CCDirector sharedDirector];
	//[director setFullScreen: ! [director isFullScreen]];
}

@end
