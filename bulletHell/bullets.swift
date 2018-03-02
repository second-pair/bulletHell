//
//  bullets.swift
//  bulletHell
//
//  Created by Blair Edwards on 02/03/2018.
//  Copyright © 2018 Blair Edwards. All rights reserved.
//

import SpriteKit

//  Each bullet will be an SKSpriteNode type

//  Group of bullets
//  These bullets fly in a fixed formation
class bulletGroup: SKSpriteNode
{
    //  Array of bullets
    var theBullets: [SKSpriteNode] = [SKSpriteNode ()]
    var patternType: Int = 0
    
    public func create (withPattern thePattern: Int = 0)
    {
        patternType = thePattern
        theBullets .append (genBullet ())
    }
    
    //  Function to generate a new bullet
    //  Will eventually take into account pattern info
    func genBullet () -> SKSpriteNode
    {
        let theBullet: SKSpriteNode = SKSpriteNode (imageNamed: "torpedo")
        theBullet .position = CGPoint (x: 50, y: -50)
        //GameScene .addChild (theBullet)
        return theBullet
    }
}

class theBullets
{
    //  Array of bullet groups
    var theGroups: [bulletGroup]!
    
    public func addGroup ()
    {
        theGroups .append (bulletGroup ())
        theGroups [0] .create (withPattern: 0)
        
    }
}
