//
//  Ground.m
//  ReichRun
//
//  Created by Gurkan Tumer on 30/12/13.
//  Copyright (c) 2013 Studio Nord. All rights reserved.
//

#import "Ground.h"

@implementation Ground

- (id)init {
    self = [super initWithFile:@"ground.png"];
    if( self != nil ) {
        [self setAnchorPoint:CGPointMake(0, 0)];
        [self setPosition:CGPointMake(0, 0)];
    }
    return self;
}

- (void) updatePosition:(NSMutableArray *)playerMovement
{
    CGFloat playerPositionX = self.position.x;
    CGFloat playerPositionY = self.position.y;
    
    // Up Arrow or W
    if ([[playerMovement objectAtIndex:0] isEqualToString:@"YES"]) // up button
    {
        if (self.velocityY > 0 - self.maxSpeed) {
            self.velocityY -= self.acceleration;
        }
    }
    // Down Arrow or S
    if ([[playerMovement objectAtIndex:1] isEqualToString:@"YES"]) // down button
    {
        if (self.velocityY < self.maxSpeed) {
            self.velocityY += self.acceleration;
        }
    }
    // left Arrow or D
    if ([[playerMovement objectAtIndex:2] isEqualToString:@"YES"]) // left button
    {
        if (self.velocityX > 0 - self.maxSpeed) {
            self.velocityX -= self.acceleration;
        }
    }
    // Right Arrow or A
    if ([[playerMovement objectAtIndex:3] isEqualToString:@"YES"]) //right button
    {
        if (self.velocityX < self.maxSpeed) {
            self.velocityX += self.acceleration;
        }
    }
    /*
    // Get window size
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    // Check if player stays within screen height
    if (playerPositionX > winSize.width - 30) {
        self.velocityX = self.velocityX * -0.8;
        playerPositionX = playerPositionX + self.velocityX;
    } else if (playerPositionX < 30) {
        self.velocityX = self.velocityX * -0.8;
        playerPositionX = playerPositionX + self.velocityX;
    }
    
    // Check if player stays within screen width
    if (playerPositionY > winSize.height - 30) {
        self.velocityY = self.velocityY * -0.8;
        playerPositionY = playerPositionY + self.velocityY;
    } else if (playerPositionY < 30) {
        self.velocityY = self.velocityY * -0.8;
        playerPositionY = playerPositionY + self.velocityY;
    }*/
    
    // Calculate friction
    self.velocityX *= self.friction;
    self.velocityY *= self.friction;
    
    // Update position
    self.position = ccp(playerPositionX += self.velocityX, playerPositionY += self.velocityY);
}

- (void)dealloc {
    
    [self removeAllChildrenWithCleanup:YES];
    [super dealloc];
}

@end
