//
//  walls.swift
//  bulletHell
//
//  Created by Blair Edwards on 19/03/2018.
//  Copyright © 2018 Blair Edwards. All rights reserved.
//

import SpriteKit


//  Global Variables


//  Class to contain multiple walls
class wallContainer: SKShapeNode
{
    var theWalls: [SKShapeNode] = [SKShapeNode ()]
    
    public func create ()
    {
        //  w = 750, h = 1334
        //  Currently adding walls manually - should use a preferences file for wall positions per level
        
        //  Verticals
        addWall (withX: -281, withY: 501, withWidth: 10, withHeight: 121)
        addWall (withX: -94, withY: -111, withWidth: 10, withHeight: 1122)
        addWall (withX: -94, withY: 612, withWidth: 10, withHeight: 121)
        addWall (withX: 94, withY: 111, withWidth: 10, withHeight: 1122)
        
        //  Horizontals Channel 1
        addWall (withX: -188, withY: -334, withWidth: 197, withHeight: 10)
        addWall (withX: -282, withY: 167, withWidth: 197, withHeight: 10)
        addWall (withX: -188, withY: 445, withWidth: 197, withHeight: 10)
        
        //  Horizontals Channel 2
        addWall (withX: -64, withY: -334, withWidth: 71, withHeight: 10)
        addWall (withX: 64, withY: -334, withWidth: 71, withHeight: 10)
        addWall (withX: 47, withY: 0, withWidth: 104, withHeight: 10)
        
        //  Horizontals Channel 3
        addWall (withX: 188, withY: -445, withWidth: 197, withHeight: 10)
        addWall (withX: 282, withY: -222, withWidth: 197, withHeight: 10)
        addWall (withX: 188, withY: 0, withWidth: 197, withHeight: 10)
        addWall (withX: 282, withY: 222, withWidth: 197, withHeight: 10)
        addWall (withX: 188, withY: 445, withWidth: 197, withHeight: 10)
        
        return
    }
    
    func addWall (withX theX: CGFloat, withY theY: CGFloat, withWidth theWidth: CGFloat, withHeight theHeight: CGFloat)
    {
        let newWall = SKShapeNode (rectOf: CGSize (width: theWidth, height: theHeight))
        newWall .position = CGPoint (x: theX, y: theY)
        newWall .zPosition = 0
        newWall .strokeColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        newWall .fillColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        
        //  Physics
        newWall .physicsBody = SKPhysicsBody (rectangleOf: newWall .frame .size)
        newWall .physicsBody? .isDynamic = false
        newWall .physicsBody? .categoryBitMask = wallCategory
        newWall .physicsBody? .collisionBitMask = playerCategory
        newWall .physicsBody? .allowsRotation = false
        
        //  Add to parent
        self .addChild (newWall)
        theWalls .append (newWall)
        
        return
    }
}
