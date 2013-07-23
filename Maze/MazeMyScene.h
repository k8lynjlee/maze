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

}


-(void)didBeginContact:(SKPhysicsContact *)contact;
@end

