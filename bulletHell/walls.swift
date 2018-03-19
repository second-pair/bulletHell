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
        
        //  Boundary
        //addWall (withX: 375, withY: 0, withWidth: 10, withHeight: 1334)
        //addWall (withX: 0, withY: -667, withWidth: 750, withHeight: 10)
        //addWall (withX: -375, withY: 0, withWidth: 10, withHeight: 1334)
        //addWall (withX: 0, withY: 667, withWidth: 750, withHeight: 10)
        
        //  Verticals
        addWall (withX: -281, withY: 501, withWidth: 10, withHeight: 111)
        addWall (withX: -94, withY: -111, withWidth: 10, withHeight: 1112)
        addWall (withX: -94, withY: 612, withWidth: 10, withHeight: 111)
        addWall (withX: 94, withY: 111, withWidth: 10, withHeight: 1112)
        
        //  Horizontals Channel 1
        addWall (withX: -188, withY: -334, withWidth: 187, withHeight: 10)
        addWall (withX: -282, withY: 167, withWidth: 187, withHeight: 10)
        addWall (withX: -188, withY: 445, withWidth: 187, withHeight: 10)
        
        //  Horizontals Channel 2
        addWall (withX: -64, withY: -334, withWidth: 61, withHeight: 10)
        addWall (withX: 64, withY: -334, withWidth: 61, withHeight: 10)
        addWall (withX: 47, withY: 0, withWidth: 94, withHeight: 10)
        
        //  Horizontals Channel 3
        addWall (withX: 188, withY: -445, withWidth: 187, withHeight: 10)
        addWall (withX: 282, withY: -222, withWidth: 187, withHeight: 10)
        addWall (withX: 188, withY: 0, withWidth: 187, withHeight: 10)
        addWall (withX: 282, withY: 222, withWidth: 187, withHeight: 10)
        addWall (withX: 188, withY: 445, withWidth: 187, withHeight: 10)
        
        return
    }
    
    func addWall (withX theX: CGFloat, withY theY: CGFloat, withWidth theWidth: CGFloat, withHeight theHeight: CGFloat)
    {
        let newWall = SKShapeNode (rectOf: CGSize (width: theWidth, height: theHeight))
        newWall .position = CGPoint (x: theX, y: theY)
        newWall .strokeColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        newWall .fillColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        
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
