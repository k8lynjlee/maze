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
static const uint32_t targetCategory = 0x1 << 2;

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
        
        
        myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        
        myLabel.text = @"Maze";
        myLabel.fontSize = 18;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMaxY(self.frame) - 220);
       // NSLog(@"Max x: %f, max y: %f", CGRectGetMaxX(self.frame), CGRectGetMaxY(self.frame));
        
        [self addChild:myLabel];
    }
    [self buildWalls];
    [self addStart];
    [self buildTargets];
    //[motion setAccelerometerUpdateInterval:0.5];
    //[motion startAccelerometerUpdates];

    found1 = NO;
    found2 = NO;
    found3 = NO;
    allFound = NO;
    //record = [[NSMutableArray alloc] initWithObjects:[found1, found2, found3, allFound, nil]];
    
    return self;
}


-(void)update:(CFTimeInterval)currentTime {

   // NSLog(@"X accel: %f", motionData->x);
    /* Called before each frame is rendered */
}

- (void)addStart
{

    sprite = [[SKSpriteNode alloc] initWithColor:[SKColor whiteColor] size:CGSizeMake(10,10)];
    sprite.position = CGPointMake(CGRectGetMidX(self.frame),
                                   CGRectGetMinY(self.frame) + 205);

     sprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:sprite.size];
     sprite.name = @"block";
     //sprite.physicsBody.dynamic = NO;
     sprite.physicsBody.usesPreciseCollisionDetection = YES;
     sprite.physicsBody.restitution = 0.6;
     sprite.physicsBody.categoryBitMask = boxCategory;
     sprite.physicsBody.collisionBitMask = wallCategory | targetCategory;

    [self addChild:sprite];
}


- (void)buildTargets
{
    target1 = [[SKSpriteNode alloc] initWithImageNamed:@"LEDred.png"];
    target2 = [[SKSpriteNode alloc] initWithImageNamed:@"LEDblue.png"];
    target3 = [[SKSpriteNode alloc] initWithImageNamed:@"LEDorange.png"];

    target1.name = @"target1";
    target2.name = @"target2";
    target3.name = @"target3";
    target1.position = CGPointMake(CGRectGetMidX(self.frame)- 120, CGRectGetMidY(self.frame) + 60);
    target2.position = CGPointMake(CGRectGetMidX(self.frame) + 40, CGRectGetMidY(self.frame) + 47);
    target3.position = CGPointMake(CGRectGetMidX(self.frame) + 150, CGRectGetMidY(self.frame) - 40);
    
   // end = [[SKSpriteNode alloc] initWithColor:[SKColor greenColor] size:CGSizeMake(35, 35)];
    
    //end.position = CGPointMake((CGRectGetMidX(self.frame)) + 50, CGRectGetMidY(self.frame) + 50);
     //   end.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:end.size];
    
    targets = [[NSArray alloc] initWithObjects:target1, target2, target3, nil];
    for (SKSpriteNode *t in targets)
    {
        t.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:14];
        t.physicsBody.dynamic = NO;
        t.physicsBody.usesPreciseCollisionDetection = YES;
        t.physicsBody.categoryBitMask = targetCategory;
        t.physicsBody.collisionBitMask = boxCategory;
        t.physicsBody.friction = 0.8;
        [self addChild:t];

    }
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
    
}

- (void)didBeginContact:(SKPhysicsContact *)contact
{
    NSLog(@"Collision");
    
    if (contact.bodyA.categoryBitMask == 2|| contact.bodyB.categoryBitMask == 2)
    {
        NSLog(@"Hit a target");
    }
}

/*
- (void)didBeginContact:(SKPhysicsContact *)contact
{
    NSLog(@"Collision");

    if (contact.bodyA.categoryBitMask == 2|| contact.bodyB.categoryBitMask == 2)
    {
        NSLog(@"Hit a target");
    }
    
 
    else if (contact.bodyA.node == end|| contact.bodyB.node == end)
    {
        NSLog(@"Hit");
     
    } */
//}


- (void)didEndContact:(SKPhysicsContact *)contact
{
    NSLog(@"Ended contact");
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
 
    
 for (UITouch *touch in touches) {
 CGPoint location = [touch locationInNode:self];

     CGPoint force = CGPointMake((location.x - sprite.position.x), (location.y - sprite.position.y));
     // NSLog(@"%f, %f", force.x, force.y);
     if (force.x > 10)
         force.x = 10;
     if (force.x < -10)
         force.x = -10;
     if (force.y > 10)
         force.y = 10;
     if (force.y < -10)
         force.y = -10;
     [sprite.physicsBody applyForce:force];
     
     /*
     NSLog(@"%d %d", abs(sprite.position.x - target1.position.x), abs(sprite.position.y - target1.position.y));
     if (abs(sprite.position.x - target1.position.x) < 15 && abs(sprite.position.y - target1.position.y) < 15)
     {
         NSLog(@"equal coordinates! ");
     }
     */
     for (int i = 0; i < 3; i++)
     {
         SKSpriteNode *tg = targets[i];
         int xDiff = abs(sprite.position.x - tg.position.x);
         int yDiff = abs(sprite.position.y - tg.position.y);
         
         if (xDiff < 40 && yDiff < 40)
         {
             NSLog(@"Equal coordinates for target %d!", i);
             [self targetHit:tg];
        
         }
     }
 }

 }

-(void)targetHit:(SKSpriteNode *)s
{
   if ([s.name  isEqual: @"target1"])
   {
       //CIFilter *filter = [[CIFilter alloc] init];
       
       //SKTexture *texture1 = [[SKTexture alloc] init];
       //[texture1 textureByApplyingCIFilter:filter];
       //s.texture = texture1;

       NSLog(@"0");
       //s.texture = textureWithImageNamed:(@"LEDred.png");
       
       [s removeFromParent];
       found1 = YES;
   }
    else if ([s.name isEqual: @"target2"])
    {
        NSLog(@"1");
        [s removeFromParent];
        found2 = YES;
    }
    else if ([s.name isEqual: @"target3"])
    {
        NSLog(@"2");
        [s removeFromParent];
        found3 = YES;
    }
    if ((found1 == YES) && (found2 == YES) && (found3 == YES))
    {
        NSLog(@"All the targets have been hit");
        myLabel.text = @"You completed the maze!";
    }
}



@end
