//
//  MazeMyScene.m
//  Maze
//
//  Created by Kaitlyn Lee on 7/22/13.
//  Copyright (c) 2013 Kaitlyn Lee. All rights reserved.
//

#import "MazeMyScene.h"
#import <CoreMotion/CoreMotion.h>
#import <SpriteKit/SpriteKit.h>
#import <QuartzCore/QuartzCore.h>




@implementation MazeMyScene
static const uint32_t boxCategory   =  0x1 << 0;
static const uint32_t wallCategory   =  0x1 << 1;

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
 
        //UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://static.webstarts.com/library/images/librarycore/circuitBoard.jpg"]]];
        //NSString *url = [[NSString alloc]
        
        SKSpriteNode *backgroundImage = [[SKSpriteNode alloc] initWithImageNamed:@"circuitBoardResized.jpg"];
        backgroundImage.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:backgroundImage];
        self.physicsWorld.gravity = CGPointMake(0,0);
        self.physicsWorld.contactDelegate = self;
        
        /*
        UIColor *photoColor = [[UIColor alloc] initWithPatternImage:img];
        SKColor *skColor = photoColor;

        self.backgroundColor = [SKColor [UIColor photoColor]];
        
          */
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
    
    //[motion setAccelerometerUpdateInterval:0.5];
    //[motion startAccelerometerUpdates];

    
    return self;
}


-(void)update:(CFTimeInterval)currentTime {

   // NSLog(@"X accel: %f", motionData->x);
    /* Called before each frame is rendered */
}

- (void)addStart
{

    sprite = [[SKSpriteNode alloc] initWithColor:[SKColor purpleColor] size:CGSizeMake(10,10)];
    sprite.position = CGPointMake(CGRectGetMidX(self.frame),
                                   CGRectGetMinY(self.frame) + 205);

     sprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:sprite.size];
     sprite.name = @"block";
     //sprite.physicsBody.dynamic = NO;
     sprite.physicsBody.usesPreciseCollisionDetection = YES;
     sprite.physicsBody.restitution = 0.6;
     sprite.physicsBody.categoryBitMask = boxCategory;
     sprite.physicsBody.collisionBitMask = wallCategory;

    [self addChild:sprite];

}

- (void)buildWalls
{
    SKSpriteNode *wall1 = [[SKSpriteNode alloc] initWithColor:[SKColor yellowColor] size:CGSizeMake(100,3)];
    wall1.position = CGPointMake(CGRectGetMidX(self.frame) + 20, 220);
    
    SKSpriteNode *wall2 = [[SKSpriteNode alloc] initWithColor:[SKColor yellowColor] size:CGSizeMake(3,28)];
    wall2.position = CGPointMake((CGRectGetMidX(self.frame) - 28), 207);
    

    SKSpriteNode *wall3 = [[SKSpriteNode alloc] initWithColor:[SKColor yellowColor] size:CGSizeMake(160,3)];
    wall3.position = CGPointMake(CGRectGetMaxX(self.frame)- 138, 250);
    
    SKSpriteNode *wall4 = [[SKSpriteNode alloc] initWithColor:[SKColor yellowColor] size:CGSizeMake(3,80)];
    wall4.position = CGPointMake(CGRectGetMaxX(self.frame) - 58, 235);
    
    SKSpriteNode *wall5 = [[SKSpriteNode alloc] initWithColor:[SKColor yellowColor] size:CGSizeMake(3,32)];
    wall5.position = CGPointMake((CGRectGetMidX(self.frame) - 57), 234);
    
    SKSpriteNode *edge1 = [[SKSpriteNode alloc] initWithColor:[SKColor blackColor] size:CGSizeMake(320, 3)];
    edge1.position = CGPointMake(160, 194);
    
    SKSpriteNode *edge2 = [[SKSpriteNode alloc] initWithColor:[SKColor blackColor] size:CGSizeMake(320, 3)];
    edge2.position = CGPointMake(160, 380);
    
    SKSpriteNode *edge3 = [[SKSpriteNode alloc] initWithColor:[SKColor blackColor] size:CGSizeMake(3, 210)];
    edge3.position = CGPointMake(-2, 300);
    
    SKSpriteNode *edge4 = [[SKSpriteNode alloc] initWithColor:[SKColor blackColor] size:CGSizeMake(3, 210)];
    edge4.position = CGPointMake(320, 300);

    NSArray *walls = [[NSArray alloc] initWithObjects:wall1, wall2, wall3, wall4, wall5, edge1, edge2, edge3, edge4,
                      nil];
 
    for (SKSpriteNode *wall in walls)
    {
        wall.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:wall.size];
        wall.physicsBody.dynamic = NO;
        wall.physicsBody.categoryBitMask = wallCategory;
        wall.physicsBody.collisionBitMask = boxCategory;
        [self addChild:wall];
        
    }
    
    end = [[SKSpriteNode alloc] initWithColor:[SKColor greenColor] size:CGSizeMake(35, 35)];
    end.position = CGPointMake((CGRectGetMidX(self.frame)) + 50, CGRectGetMidY(self.frame) + 50);
    end.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:end.size];
    end.physicsBody.dynamic = NO;
    end.physicsBody.usesPreciseCollisionDetection = YES;

    [self addChild:end];
    
}


-(void)didBeginContact:(SKPhysicsContact *)contact
{
    NSLog(@"Collision");

    if (contact.bodyA.node == end|| contact.bodyB.node == end)
    {
        NSLog(@"Hit");
        /*
        sprite.position = CGPointMake(CGRectGetMidX(self.frame),
                                      CGRectGetMinY(self.frame) + 205);
         */
    }
}


-(void)didEndContact:(SKPhysicsContact *)contact
{
    NSLog(@"Ended contact");
}

 -(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
 
    
 for (UITouch *touch in touches) {
 CGPoint location = [touch locationInNode:self];

     CGPoint force = CGPointMake((location.x - sprite.position.x), (location.y - sprite.position.y));
     NSLog(@"%f, %f", force.x, force.y);
     if (force.x > 10)
         force.x = 10;
     if (force.x < -10)
         force.x = -10;
     if (force.y > 10)
         force.y = 10;
     if (force.y < -10)
         force.y = -10;
     [sprite.physicsBody applyForce:force];

 }

 }


@end
