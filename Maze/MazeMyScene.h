//
//  MazeMyScene.h
//  Maze
//

//  Copyright (c) 2013 Kaitlyn Lee. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>


@interface MazeMyScene : SKScene<SKPhysicsContactDelegate>
{
    SKSpriteNode *sprite;
    SKSpriteNode *end;
    SKSpriteNode *target1;
    SKSpriteNode *target2;
    SKSpriteNode *target3;
    NSArray *targets;
    BOOL found1;
    BOOL found2;
    BOOL found3;
    BOOL allFound;
    NSMutableArray *record;
    SKLabelNode *myLabel;
    

}

//-(void)didBeginContact:(SKPhysicsContact *)contact;

@end

