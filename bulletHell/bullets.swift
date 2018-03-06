//
//  bullets.swift
//  bulletHell
//
//  Created by Blair Edwards on 02/03/2018.
//  Copyright © 2018 Blair Edwards. All rights reserved.
//

import SpriteKit
import GameKit

//  Each bullet will be an SKSpriteNode type
//  Look into using property lists later on

//  Global Variaables
let maxPatterns: Int = 2
let pattern0Range: Int = 100
let pattern0Speed: Double = 4
let pattern1Range: Int = 50
let pattern1Speed: Double = 3




//  Class to contrain and manipulate a group of bullets
//  These bullets fly in a fixed formation
class bulletGroup: SKSpriteNode
{
    //  Array of bullets
    var theBullets: [SKSpriteNode] = [SKSpriteNode ()]
    var patternType: Int = 0
    
    var travelSpeed: Double = 1
    var theVelocity: CGVector = CGVector (dx: 0, dy: 0)
    
    public func update ()
    {
        //  Update overall position
        self .position .x += theVelocity .dx
        self .position .y += theVelocity .dy
        
        //  Update bullet positions
        //  Maybe make bullet class with relative position?
        
        //  Add group velocity to player
        //  Add local spin etc
        //  Look to see if there are known methods for this
        //  Will probably need to account for time
        //  Check if bullet pack is outside of game window
        return
    }
    
    public func create (withPattern thePattern: Int = 0, withPlayerAt playerPos: CGPoint)
    {
        //  Generate bullets according to the pattern type
        //  This needs to happen first, as we set some variables based off this information
        patternType = thePattern
        switch patternType
        {
        case 0:
            pattern0 ()
        case 1:
            pattern1 ()
        default:
            pattern0 ()
        }
        
        //  Grab the group's centre point
        self .position = CGPoint (x: 0, y: 0)
        
        //  Calculate the group's vector to the player
        theVelocity = vectorTowards (pointFrom: self .position, pointTo: playerPos)
        
        //  Calculate spawn location somehow
        //  Add group velocity to player
        //  Add local spin etc
    }
    
    //  Maybe have one of these per pattern type?
    func pattern0 ()
    {
        travelSpeed = pattern0Speed
        //  Create 6 randomised bullets
        for _ in 0 ... 5
        {
            let theRandomDist = GKRandomDistribution (randomSource: GKLinearCongruentialRandomSource (), lowestValue: -pattern0Range, highestValue: pattern0Range)
            genBullet (overrideX: theRandomDist .nextInt (), overrideY: theRandomDist .nextInt ())
        }
        return
    }
    
    func pattern1 ()
    {
        travelSpeed = pattern1Speed
        genBullet (overrideX: Int (self .position .x) + pattern1Range, overrideY: Int (self .position .y) + pattern1Range)
        genBullet (overrideX: Int (self .position .x) + pattern1Range, overrideY: Int (self .position .y) - pattern1Range)
        genBullet (overrideX: Int (self .position .x) - pattern1Range, overrideY: Int (self .position .y) + pattern1Range)
        genBullet (overrideX: Int (self .position .x) - pattern1Range, overrideY: Int (self .position .y) - pattern1Range)
        return
    }
    
    //  Function to generate a new bullet
    //  Will eventually take into account pattern info
    func genBullet ()
    {
        //  Overload with no parameters -> generate random X and Y
        let theRandomDist = GKRandomDistribution (randomSource: GKLinearCongruentialRandomSource (), lowestValue: -250, highestValue: 250)
        genBulletOverrideCollector (withX: theRandomDist .nextInt (), withY: theRandomDist .nextInt ())
        return
    }
    
    func genBullet (overrideX newX: Int, overrideY newY: Int)
    {
        //  Overload with X and Y given
        genBulletOverrideCollector (withX: newX, withY: newY)
        return
    }
    
    //  Shared code used by both overload functions
    func genBulletOverrideCollector (withX theX: Int, withY theY: Int)
    {
        let theBullet: SKSpriteNode = SKSpriteNode (imageNamed: "torpedo")
        theBullet .position = CGPoint (x: theX, y: theY)
        theBullet .physicsBody = SKPhysicsBody (circleOfRadius: theBullet .size .width / 2)
        theBullet .physicsBody? .isDynamic = true
        self .addChild (theBullet)
        theBullets .append (theBullet)
        return
    }
    
    //  Calculates the normalised vector between two points
    func vectorTowards (pointFrom thePoint1: CGPoint, pointTo thePoint2: CGPoint) -> CGVector
    {
        let xDiff = Double (thePoint2 .x - thePoint1 .x)
        let yDiff = Double (thePoint2 .y - thePoint1 .y)
        let normaliser = travelSpeed / sqrt (xDiff * xDiff + yDiff * yDiff)
        let theVector = CGVector (dx: xDiff * normaliser, dy: yDiff * normaliser)
        return theVector
    }
    
    public func destroy ()
    {
        for theBullet in theBullets
        {
            theBullet .removeFromParent ()
        }
        self .removeFromParent ()
    }
}



//  Class to contain and manipulate an array of bullet groups
class bulletGroupContainer: SKSpriteNode
{
    //  Array of bullet groups
    var theGroups: [bulletGroup] = [bulletGroup ()]
    var nextPattern: Int = 0
    {
        didSet
        {
            if nextPattern >= maxPatterns
            {
                nextPattern = 0
                return
            }
        }
    }
    
    public func update ()
    {
        for currGroup in theGroups
        {
            currGroup .update ()
        }
    }
    
    public func destroyAllBullets ()
    {
        for theGroup in theGroups
        {
            theGroup .removeFromParent ()
            theGroups .removeFirst ()
        }
        return
    }
    
    public func addGroup (withPlayerAt playerPos: CGPoint)
    {
        addGroupOverrideCollector (withPattern: nextPattern, withPlayerAt: playerPos)
        nextPattern += 1
        return
    }
    
    public func addGroup (overridePattern newPattern: Int, withPlayerAt playerPos: CGPoint)
    {
        addGroupOverrideCollector (withPattern: newPattern, withPlayerAt: playerPos)
        return
    }
    
    func addGroupOverrideCollector (withPattern thePattern: Int, withPlayerAt playerPos: CGPoint)
    {
        let newGroup = bulletGroup ()
        newGroup .create (withPattern: thePattern, withPlayerAt: playerPos)
        self .addChild (newGroup)
        theGroups .append (newGroup)
        return
    }
    
    public func destroy ()
    {
        for theGroup in theGroups
        {
            theGroup .destroy ()
        }
        self .removeFromParent ()
    }
}
