//
//  GameScene.swift
//  bulletHell
//
//  Created by Blair Edwards on 27/02/2018.
//  Copyright © 2018 Blair Edwards. All rights reserved.
//

//  Assets From:  https://github.com/brianadvent/SpaceGameReloaded

//  TODO:  Everything.

import SpriteKit
import GameplayKit
import CoreMotion

//  Global Bit Masks
public let playerCategory: UInt32 = 0x1 << 0
public let bulletCategory: UInt32 = 0x1 << 1
public let wallCategory: UInt32 = 0x1 << 2

class GameScene: SKScene, SKPhysicsContactDelegate
{
    //  Variables & Parameters
    let playerMoveScaleX: CGFloat = 25
    let playerMoveScaleY: CGFloat = 25
    let playerMoveRatioX: CGFloat = 0.9
    let playerMoveRatioY: CGFloat = 0.9
    
    var background: SKEmitterNode!
    var player: SKSpriteNode!
    var exit: SKSpriteNode!
    var healthPowerup: SKSpriteNode!
    var theBullets: bulletGroupContainer!
    var bulletSpawnTimer: Timer!
    var bulletDestroyTimer: Timer!
    var theWalls: wallContainer!
    
    let motionManager = CMMotionManager ()
    var xAcceleration: CGFloat = 0
    var yAcceleration: CGFloat = 0
    
    //var lifeMeter: SKSpriteNode!
    var lifeMeter: SKLabelNode!
    var lifeCounter: Int = 0
    {
        didSet
        {
            lifeMeter .text = "Life:  \(lifeCounter)"
        }
    }
    
    //  Called before each frame is rendered
    override func update (_ currentTime: TimeInterval)
    {
        theBullets .update ()
        return
    }
    
    
    
    override func didSimulatePhysics ()
    {
        //  Add tilt-acceleration to player's position
        player .position .x += xAcceleration * playerMoveScaleX
        player .position .y += yAcceleration * playerMoveScaleY
        
        //  Out-of-bounds handling - will hopefully just be a catch-all later
        if player .position .x < -self .frame .size .width / 2
        {
            player .position .x = -self .frame .size .width / 2
        }
        else if player .position .x > self .frame .size .width / 2
        {
            player .position .x = self .frame .size .width / 2
        }
        if player .position .y < -self .frame .size .height / 2
        {
            player .position .y = -self .frame .size .height / 2
        }
        else if player .position .y > self .frame .size .height / 2
        {
            player .position .y = self .frame .size .height / 2
        }
    }
    
    
    
    override func didMove (to view: SKView)
    {
        //  Physics
        self .physicsWorld .gravity = CGVector (dx: 0, dy: 0)
        self .physicsWorld .contactDelegate = self
        
        //  Handle accelerometer data
        motionManager .accelerometerUpdateInterval = (1/60)
        motionManager .startAccelerometerUpdates (to: OperationQueue .current!)
        { (data: CMAccelerometerData?, error: Error?) in
            if let accelerometerData = data
            {
                //  Store weighted accelerometer data for future use (requires past data to work well)
                self .xAcceleration = CGFloat (accelerometerData .acceleration .x) * self .playerMoveRatioX + self .xAcceleration * (1 - self .playerMoveRatioX)
                self .yAcceleration = CGFloat (accelerometerData .acceleration .y) * self .playerMoveRatioY + self .yAcceleration * (1 - self .playerMoveRatioY)
            }
        }
        
        //  Initialise background
        background = SKEmitterNode (fileNamed: "backgroundSmoke.sks")
        background .position = CGPoint (x: 0, y: 0)
        background .zPosition = -1
        self .addChild (background)
        
        //  Initialise life meter
        lifeMeter = SKLabelNode ()
        lifeCounter = 100
        lifeMeter .position = CGPoint (x: lifeMeter .frame .size .width / 2 - self .frame .size .width / 2 + 25, y: self .frame .size .height / 2 - lifeMeter .frame .size .height / 2 - 25)
        lifeMeter .fontSize = 30
        self .addChild (lifeMeter)
        
        //  Initialise player
        player = SKSpriteNode (imageNamed: "shuttle")
        player .setScale (0.5)
        player .position = CGPoint (x: -250, y: -350)
        player .physicsBody = SKPhysicsBody (rectangleOf: player .size)
        player .physicsBody? .isDynamic = true
        player .physicsBody? .categoryBitMask = playerCategory
        player .physicsBody? .allowsRotation = false
        self .addChild (player)
        
        //  Initialise bullets
        theBullets = bulletGroupContainer ()
        self .addChild (theBullets)
        bulletSpawnTimer = Timer .scheduledTimer (timeInterval: 2.0, target: self, selector: #selector (spawnBulletGroup), userInfo: nil, repeats: true)
        
        //  Initialise walls
        theWalls = wallContainer ()
        self .addChild (theWalls)
        theWalls .create ()
        
        
        //  Done!
        return
    }
    
    @objc func spawnBulletGroup ()
    {
        theBullets .addGroup (withPlayerAt: player .position)
        return
    }
    
    @objc func destroyAllBullets ()
    {
        //theBullets .destroyAllBullets ()
        theBullets .destroy ()
        return
    }
    
    
    
    //  Collision Physics
    func didBegin (_ contact: SKPhysicsContact)
    {
        /*
         001 = 0x1 = Player
         010 = 0x2 = Bullet
         100 = 0x4 = Wall
         011 = 0x3 = Player + Bullet
         101 = 0x5 = Player + Wall
         110 = 0x6 = Bullet + Wall
        */
        
        var bodyLower: SKPhysicsBody
        var bodyUpper: SKPhysicsBody
        
        //  Determine order of bodies
        if contact .bodyA .categoryBitMask < contact .bodyB .categoryBitMask
        {
            bodyLower = contact .bodyA
            bodyUpper = contact .bodyB
        }
        else
        {
            bodyLower = contact .bodyB
            bodyUpper = contact .bodyA
        }
        
        //  Check for player-bullet collision
        if (bodyLower .categoryBitMask & playerCategory) != 0 && (bodyUpper .categoryBitMask & bulletCategory) != 0
        {
            collisionPlayerBullet (hitBy: bodyUpper .node as! SKSpriteNode)
        }
        
        //  Check for player-wall collision
        //  Check for bullet-wall collision
    }
    
    //  Function for when the player is hit by a bullet
    func collisionPlayerBullet (hitBy theBullet: SKSpriteNode)
    {
        theBullet .removeFromParent ()
        lifeCounter -= 10
        return
    }
    
    //  Function for when the player hits a wall
    func collisionPlayerWall ()
    {
        return
    }
    
    //  Function for when a bullet hits a wall
    func collisionBulletWall (hitBy theBullet: SKSpriteNode)
    {
        theBullet .removeFromParent ()
        return
    }
}
