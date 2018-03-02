//
//  GameScene.swift
//  bulletHell
//
//  Created by Blair Edwards on 27/02/2018.
//  Copyright © 2018 Blair Edwards. All rights reserved.
//

//  TODO:  Generated bullets aren't created properly - only manual bullet shows up
//  Timer seems to work fine though

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate
{
    var background: SKEmitterNode!
    var player: SKSpriteNode!
    var exit: SKSpriteNode!
    var healthPowerup: SKSpriteNode!
    var testBullet: SKSpriteNode!
    var testBulletGroup: bulletGroup = bulletGroup ()
    var bulletSpawnTimer: Timer!
    
    
    //var lifeMeter: SKSpriteNode!
    var lifeMeter: SKLabelNode!
    var lifeCounter: Int = 0
    {
        didSet
        {
            lifeMeter .text = "Life:  \(lifeCounter)"
        }
    }
    
    override func didMove (to view: SKView)
    {
        //  Physics
        self .physicsWorld .gravity = CGVector (dx: 0, dy: 0)
        self .physicsWorld .contactDelegate = self
        
        //  Initialise background
        background = SKEmitterNode (fileNamed: "backgroundSmoke.sks")
        background .position = CGPoint (x: 0, y: 0)
        background .zPosition = -1
        self .addChild (background)
        
        //  Initialise player
        player = SKSpriteNode (imageNamed: "shuttle")
        player .position = CGPoint (x: 1000, y: 0)
        self .addChild (player)
        
        //  Initialise life meter
        lifeMeter = SKLabelNode ()
        lifeCounter = 100
        lifeMeter .position = CGPoint (x: lifeMeter .frame .size .width / 2 - self .frame .size .width / 2 + 25, y: self .frame .size .height / 2 - lifeMeter .frame .size .height / 2 - 25)
        lifeMeter .fontSize = 30
        self .addChild (lifeMeter)
        
        //  Initialise bullets
        testBullet = SKSpriteNode (imageNamed: "torpedo")
        bulletSpawnTimer = Timer .scheduledTimer (timeInterval: 1.5, target: self, selector: #selector (spawnBulletGroup), userInfo: nil, repeats: true)
        self .addChild (testBulletGroup)
        self .addChild (testBullet)
    }
    
    override func update (_ currentTime: TimeInterval)
    {
        // Called before each frame is rendered
    }
    
    @objc func spawnBulletGroup ()
    {
        testBulletGroup .create (withPattern: 0)
        testBullet .position = CGPoint (x: -50, y: 50)
    }
}
