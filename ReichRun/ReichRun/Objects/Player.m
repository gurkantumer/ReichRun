//
//  Player.m
//  ReichRun
//
//  Created by Gurkan Tumer on 30/12/13.
//  Copyright (c) 2013 Studio Nord. All rights reserved.
//

#import "Player.h"
#import "LevelManager.h"

@implementation Player

- (id)initWithGround:(CCSprite*)gr
{
    self = [super initWithFile:@"char.png"];
    if( self != nil )
    {
        ground = gr;
        [self prepare];
        [self setPosition:CGPointMake(100, 100)];
    }
    return self;
}

- (void) setPositionGraphic:(NSMutableArray *)movementData
{
//    NSLog(@"movementData : %@",[movementData description]);
}

- (void) updatePosition:(NSMutableArray *)playerMovement
{
    CGFloat playerPositionX = self.position.x;
    CGFloat playerPositionY = self.position.y;
    
    // Up Arrow or W
    if ([[playerMovement objectAtIndex:0] isEqualToString:@"YES"]) // up button
    {
        if (self.velocityY < self.maxSpeed) {
            self.velocityY += self.acceleration;
        }
    }
    // Down Arrow or S
    if ([[playerMovement objectAtIndex:1] isEqualToString:@"YES"]) // down button
    {
        
        if (self.velocityY > 0 - self.maxSpeed) {
            self.velocityY -= self.acceleration;
        }
    }
    // left Arrow or D
    if ([[playerMovement objectAtIndex:2] isEqualToString:@"YES"]) // left button
    {
        if (self.velocityX < self.maxSpeed) {
            self.velocityX += self.acceleration;
        }
    }
    // Right Arrow or A
    if ([[playerMovement objectAtIndex:3] isEqualToString:@"YES"]) //right button
    {
        if (self.velocityX > 0 - self.maxSpeed) {
            self.velocityX -= self.acceleration;
        }
    }
    
    // Get window size
    CGSize walkSize = ground.contentSize;
    
    // Check if player stays within screen height
    if (playerPositionX > walkSize.width - 100) {
        self.velocityX = self.velocityX * -1;//0.8;
        playerPositionX = playerPositionX + self.velocityX;
     } else if (playerPositionX < 100) {
         self.velocityX = self.velocityX * -1;//0.8;
         playerPositionX = playerPositionX + self.velocityX;
     }
     
     // Check if player stays within screen width
     if (playerPositionY > walkSize.height - 100) {
         self.velocityY = self.velocityY * -1;//0.8;
         playerPositionY = playerPositionY + self.velocityY;
     } else if (playerPositionY < 100) {
         self.velocityY = self.velocityY * -1;//0.8;
         playerPositionY = playerPositionY + self.velocityY;
     }
    
    // Calculate friction
    self.velocityX *= self.friction;
    self.velocityY *= self.friction;
    
    // Update position
    self.position = ccp(playerPositionX += self.velocityX, playerPositionY += self.velocityY);
    
}

- (void) notificationHandler:(NSNotification*)notify
{
    if ([notify.name isEqualToString:kHEALTH_ADD]) {
        [self updateHealth:[LevelManager sharedManager].healthValue];
    }
    if ([notify.name isEqualToString:kHEALTH_DROP]) {
        [self updateHealth:-30];
    }
}

- (void)dealloc {

    [self removeAllChildrenWithCleanup:YES];
    [super dealloc];
}

@end
