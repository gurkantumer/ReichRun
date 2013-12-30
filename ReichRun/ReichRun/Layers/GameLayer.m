//
//  GameLayer.m
//  ReichRun
//
//  Created by Gurkan Tumer on 30/12/13.
//  Copyright (c) 2013 Studio Nord. All rights reserved.
//

#import "GameLayer.h"
#import "GameManager.h"

@implementation GameLayer

@synthesize playerMovement;

-(id) init
{
	if( (self=[super init]) )
    {
    
        playerMovement = [[NSMutableArray alloc] init];
        [playerMovement addObject:@"NO"];
        [playerMovement addObject:@"NO"];
        [playerMovement addObject:@"NO"];
        [playerMovement addObject:@"NO"];
        
        isSpacePressed = NO;
        
        [[GameManager sharedManager] setKeyboardEnabledState:YES];
        
        CCLayerColor* colorLayer = [CCLayerColor layerWithColor:CC_GRAY];
        [self addChild:colorLayer z:0];
        
        self.contentSize = CGSizeMake(self.contentSize.width, self.contentSize.height);
	}
	return self;
}

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
    GameLayer *layer = [GameLayer node];
	
	[scene addChild: layer];
	return scene;
}

- (void)tick: (ccTime) dt
{
    NSLog(@"tick");
}

- (BOOL) ccKeyDown:(NSEvent*)event
{
    NSString * character = [event characters];
    unichar keyCode = [character characterAtIndex: 0];
    
    // keyboard available
    if ([[GameManager sharedManager] getKeyboardEnabledState])
    {
        NSLog(@"%hu",keyCode);
        
        if (keyCode == kCAPS_ON_UP || keyCode== kCAPS_OFF_UP) { [playerMovement replaceObjectAtIndex:0 withObject:@"YES"]; } // Up
        if (keyCode == kCAPS_ON_DOWN || keyCode== kCAPS_OFF_DOWN) { [playerMovement replaceObjectAtIndex:1 withObject:@"YES"]; } // Down
        if (keyCode == kCAPS_ON_LEFT || keyCode== kCAPS_OFF_LEFT) { [playerMovement replaceObjectAtIndex:2 withObject:@"YES"]; } // Left
        if (keyCode == kCAPS_ON_RIGHT || keyCode== kCAPS_OFF_RIGHT) { [playerMovement replaceObjectAtIndex:3 withObject:@"YES"]; } // Right
        if (keyCode == 32) { isSpacePressed = YES; } // space
    }
    
    if (keyCode == 27) // escape
    {
        /*if ([[GameManager sharedManager] getKeyboardEnabledState]){
            [[GameManager sharedManager] setKeyboardEnabledState:NO];
        }else{
            [[GameManager sharedManager] setKeyboardEnabledState:YES];
        }*/
    }
    
    return YES;
}

- (BOOL) ccKeyUp:(NSEvent *)event
{
    NSString * character = [event characters];
    unichar keyCode = [character characterAtIndex: 0];
    
    // keyboard available
    if ([[GameManager sharedManager] getKeyboardEnabledState])
    {
        // Set unpressed key to false
        if (keyCode == kCAPS_ON_UP || keyCode== kCAPS_OFF_UP) { [playerMovement replaceObjectAtIndex:0 withObject:@"NO"]; } // Up
        if (keyCode == kCAPS_ON_DOWN || keyCode== kCAPS_OFF_DOWN) { [playerMovement replaceObjectAtIndex:1 withObject:@"NO"]; } // Down
        if (keyCode == kCAPS_ON_LEFT || keyCode== kCAPS_OFF_LEFT) { [playerMovement replaceObjectAtIndex:2 withObject:@"NO"]; } // Left
        if (keyCode == kCAPS_ON_RIGHT || keyCode== kCAPS_OFF_RIGHT) { [playerMovement replaceObjectAtIndex:3 withObject:@"NO"]; } // Right
        if (keyCode == 32) { isSpacePressed = NO; } // space
    }
    
    return YES;
}

- (void) dealloc
{
    [self removeAllChildrenWithCleanup:YES];
    
    [playerMovement removeAllObjects];
    playerMovement = nil;
    
    [super dealloc];
}

@end
