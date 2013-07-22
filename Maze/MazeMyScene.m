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





@implementation MazeMyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.physicsWorld.gravity = CGPointMake(0,0);
        self.physicsWorld.contactDelegate = self;
        
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

    sprite = [[SKSpriteNode alloc] initWithColor:[SKColor purpleColor] size:CGSizeMake(15,15)];
    sprite.position = CGPointMake(CGRectGetMidX(self.frame),
                                   CGRectGetMinY(self.frame) + 205);

     sprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:sprite.size];
     sprite.name = @"block";
     sprite.physicsBody.dynamic = NO;
     sprite.physicsBody.usesPreciseCollisionDetection = YES;
     sprite.physicsBody.restitution = 0.6;
     sprite.physicsBody.categoryBitMask = 0;
     sprite.physicsBody.collisionBitMask = 1;

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
    

    NSArray *walls = [[NSArray alloc] initWithObjects:wall1, wall2, wall3, wall4, wall5, nil];
 
    for (SKSpriteNode *wall in walls)
    {
        wall.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:wall.size];
        wall.physicsBody.dynamic = NO;
        wall.physicsBody.categoryBitMask = 1;
        wall.physicsBody.collisionBitMask = 0;
        [self addChild:wall];
        
    }
    
    /*
     [self addChild:wall1];
     [self addChild:wall2];
     [self addChild:wall3];
     [self addChild:wall4];
     [self addChild:wall5];
     
    wall1.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:wall1.size];
    wall2.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:wall2.size];
    wall3.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:wall3.size];
    wall4.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:wall4.size];
    wall5.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:wall5.size];
  
    
    wall1.physicsBody.dynamic = NO;
    wall2.physicsBody.dynamic = NO;
    wall3.physicsBody.dynamic = NO;
    wall4.physicsBody.dynamic = NO;
    wall5.physicsBody.dynamic = NO;
  */
    
    end = [[SKSpriteNode alloc] initWithColor:[SKColor greenColor] size:CGSizeMake(35, 35)];
    end.position = CGPointMake((CGRectGetMidX(self.frame)) + 50, CGRectGetMidY(self.frame) + 50);
    end.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:end.size];
    end.physicsBody.dynamic = NO;
    end.physicsBody.usesPreciseCollisionDetection = YES;

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

// figure out moved

-(void)didBeginContact:(SKPhysicsContact *)contact
{
    NSLog(@"Collision");

    SKPhysicsBody *firstBody, *secondBody;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask)
    {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    }
    else
    {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }

   // if (firstBody.categoryBitMask & )
    
    
}

 -(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
 
    
 for (UITouch *touch in touches) {
 CGPoint location = [touch locationInNode:self];

     //NSLog(@"Difference is %d, %d", abs(location.x - sprite.position.x), abs(location.y - sprite.position.y));
     SKAction *move = [SKAction moveTo:location duration:1];
     /*
     
     SKAction *move = [SKAction sequence:@[[SKAction waitForDuration:0.3],[SKAction moveTo:location duration:1] ]]; */
    [sprite runAction:move];
    // [sprite setPosition:location];


 }
     

 }

/*
- (void)didSimulatePhysics
{
    NSLog(@"Simulated");
    [self enumerateChildNodesWithName:@"block" usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.position.y < 0) {
            sprite.position = CGPointMake(CGRectGetMidX(self.frame),
                                          CGRectGetMinY(self.frame) + 205);
        }
        
    }];
   
}
 */


@end
