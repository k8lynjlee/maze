//
//  MazeMyScene.m
//  Maze
//
//  Created by Kaitlyn Lee on 7/22/13.
//  Copyright (c) 2013 Kaitlyn Lee. All rights reserved.
//

#import "MazeMyScene.h"
#import <CoreMotion/CoreMotion.h>

@interface MazeMyScene ()

@property(readonly, nonatomic) CMAcceleration acceleration;

@end

@implementation MazeMyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        
        myLabel.text = @"Maze";
        myLabel.fontSize = 30;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame));
        
        [self addChild:myLabel];
    }
    return self;
}



-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

- (void)viewDidLoad
{
 //
}

/*
 -(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
 
 for (UITouch *touch in touches) {
 CGPoint location = [touch locationInNode:self];
 
 SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
 
 sprite.position = location;
 
 SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
 
 [sprite runAction:[SKAction repeatActionForever:action]];
 
 [self addChild:sprite];
 }
 }
 */


@end
