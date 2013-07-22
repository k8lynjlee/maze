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
{
    CMAcceleration *motionData;
    CMAccelerometerData *data;
    //CMAccelerometerHandler handler;
    CMMotionManager *motion;
}

@property(readonly, nonatomic) CMAcceleration acceleration;

@end

@implementation MazeMyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */

        self.backgroundColor = [SKColor lightGrayColor];
        
        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        
        myLabel.text = @"Maze";
        myLabel.fontSize = 18;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMaxY(self.frame) - 220);
        NSLog(@"Max x: %f, max y: %f", CGRectGetMaxX(self.frame), CGRectGetMaxY(self.frame));
        
        [self addChild:myLabel];
    }
    [self buildWalls];
    [self addStart];
    
    [motion setAccelerometerUpdateInterval:0.5];
    [motion startAccelerometerUpdates];

    
    return self;
}


-(void)update:(CFTimeInterval)currentTime {

   // NSLog(@"X accel: %f", motionData->x);
    /* Called before each frame is rendered */
}

- (void)addStart
{

    sprite = [[SKSpriteNode alloc] initWithColor:[SKColor purpleColor] size:CGSizeMake(15,15)];
    sprite.position = CGPointMake(CGRectGetMidX(self.frame),
                                   CGRectGetMinY(self.frame) + 205);
     sprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:sprite.size];
     sprite.physicsBody.dynamic = NO;
    [self addChild:sprite];

}

- (void)buildWalls
{
    SKSpriteNode *wall1 = [[SKSpriteNode alloc] initWithColor:[SKColor blueColor] size:CGSizeMake(100,3)];
    wall1.position = CGPointMake(CGRectGetMidX(self.frame) + 20, 220);
    
    SKSpriteNode *wall2 = [[SKSpriteNode alloc] initWithColor:[SKColor blueColor] size:CGSizeMake(3,28)];
    wall2.position = CGPointMake((CGRectGetMidX(self.frame) - 28), 207);
    

    SKSpriteNode *wall3 = [[SKSpriteNode alloc] initWithColor:[SKColor blueColor] size:CGSizeMake(160,3)];
    wall3.position = CGPointMake(CGRectGetMaxX(self.frame)- 138, 250);
    
    SKSpriteNode *wall4 = [[SKSpriteNode alloc] initWithColor:[SKColor blueColor] size:CGSizeMake(3,80)];
    wall4.position = CGPointMake(CGRectGetMaxX(self.frame) - 58, 235);
    
    SKSpriteNode *wall5 = [[SKSpriteNode alloc] initWithColor:[SKColor blueColor] size:CGSizeMake(3,36)];
    wall5.position = CGPointMake((CGRectGetMidX(self.frame) - 55), 230);
    
    
    wall1.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:sprite.size];
    wall2.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:sprite.size];
    wall3.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:sprite.size];
    wall4.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:sprite.size];
    wall5.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:sprite.size];
    
    
    [self addChild:wall1];
    [self addChild:wall2];
    [self addChild:wall3];
    [self addChild:wall4];
    [self addChild:wall5];
    
    
    SKSpriteNode *end = [[SKSpriteNode alloc] initWithColor:[SKColor greenColor] size:CGSizeMake(35, 35)];
    end.position = CGPointMake((CGRectGetMidX(self.frame)) + 50, CGRectGetMidY(self.frame) + 50);
    [self addChild:end];
    
}


/*
- (SKAction *)touchesBegan:(NSSet *)touches withTouch:(UITouch *)touch
{
    NSLog(@"Touch");
    CGPoint clickPoint = [touch locationInView:self.view ];
    CGPoint charPos = self.position;
    CGFloat distance = sqrtf((clickPoint.x-charPos.x)*(clickPoint.x-charPos.x)+
                             (clickPoint.y-charPos.y)*(clickPoint.y-charPos.y));
    
    SKAction *moveToClick = [SKAction moveTo:clickPoint duration:distance/10];
    return moveToClick;
}
 */


 -(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
 
    
 for (UITouch *touch in touches) {
 CGPoint location = [touch locationInNode:self];
 
 sprite.position = location;


 }

 }



@end
