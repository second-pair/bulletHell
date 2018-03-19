//
//  walls.swift
//  bulletHell
//
//  Created by Blair Edwards on 19/03/2018.
//  Copyright © 2018 Blair Edwards. All rights reserved.
//

import SpriteKit


//  Global Variables

/*/  Class for an individual wall
class wall: SKShapeNode
{
    public func create (usingX theX: CGFloat, usingY theY: CGFloat, withWidth theWidth: CGFloat, withHeight theHeight: CGFloat)
    {
        self = CGRect
        self .position .x = theX
        self .position .y = theY
        self .lineWidth = 10
        //self .size .width = theWidth
        //self .size .height = theHeight
        self .fillColor = SKColor .brown
        
        //  Physics
        //self .physicsBody = SKPhysicsBody (rectangleOf: self .size)
        self .physicsBody? .isDynamic = true
        self .physicsBody? .categoryBitMask = wallCategory
        self .physicsBody? .pinned = true
        self .physicsBody? .allowsRotation = false
        return
    }
}*/

//  Class to contain multiple walls
class wallContainer: SKShapeNode
{
    var theWalls: [SKShapeNode] = [SKShapeNode ()]
    
    public func create ()
    {
        let newWall = SKShapeNode (rectOf: CGSize (width: 10, height: 100))
        newWall .position = CGPoint (x: -300, y: -350)
        newWall .strokeColor = UIColor (cgColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0))
        newWall .fillColor = UIColor (cgColor: #colorLiteral(red: 0, green: 0.6907517032, blue: 0.8886212759, alpha: 1))
        
        //  Physics
        newWall .physicsBody = SKPhysicsBody (rectangleOf: newWall .frame .size)
        newWall .physicsBody? .isDynamic = true
        newWall .physicsBody? .categoryBitMask = wallCategory
        newWall .physicsBody? .pinned = true
        newWall .physicsBody? .allowsRotation = false
        
        //  Add to parent
        self .addChild (newWall)
        theWalls .append (newWall)
        return
    }
}
