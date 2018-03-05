//
//  bullets.swift
//  bulletHell
//
//  Created by Blair Edwards on 02/03/2018.
//  Copyright © 2018 Blair Edwards. All rights reserved.
//

import SpriteKit

//  Each bullet will be an SKSpriteNode type
//  Look into using property lists later on

//  Group of bullets
//  These bullets fly in a fixed formation
class bulletGroup: SKSpriteNode
{
    //  Array of bullets
    var theBullets: [SKSpriteNode] = [SKSpriteNode ()]
    var patternType: Int = 0
    
    var centrePoint: CGPoint!
    var theVelocity: CGVector!
    
    public func update ()
    {
        //  Add group velocity to player
        //  Add local spin etc
        //  Look to see if there are known methods for this
        //  Will probably need to account for time
        return
    }
    
    public func create (withPattern thePattern: Int = 0)
    {
        //  For now, we're just creating 20 random bullets
        for _ in 0 ... 499
        {
            patternType = thePattern
            genBullet ()
        }
        
        //  Calculate spawn location somehow
        //  Known centre-point
        //  Add group velocity to player
        //  Add local spin etc
    }
    
    //  Maybe have one of these per pattern type?
    func pattern0 ()
    {
        return
    }
    
    //  Function to generate a new bullet
    //  Will eventually take into account pattern info
    func genBullet ()
    {
        //  Overload with no parameters -> generate random X and Y
        genBulletOverrideCollector (withX: Int (arc4random_uniform (500)) - 250, withY: Int (arc4random_uniform (500)) - 250)
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
        self .addChild (theBullet)
        theBullets .append (theBullet)
        return
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

class bulletGroupContainer: SKSpriteNode
{
    //  Array of bullet groups
    var theGroups: [bulletGroup] = [bulletGroup ()]
    var nextPattern: Int = 0
    
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
    
    public func addGroup ()
    {
        addGroupOverrideCollector (withPattern: nextPattern)
        return
    }
    
    public func addGroup (overridePattern newPattern: Int)
    {
        addGroupOverrideCollector (withPattern: newPattern)
        return
    }
    
    func addGroupOverrideCollector (withPattern thePattern: Int)
    {
        let newGroup = bulletGroup ()
        newGroup .create (withPattern: thePattern)
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
