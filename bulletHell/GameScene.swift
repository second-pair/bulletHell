//
//  GameScene.swift
//  bulletHell
//
//  Created by Blair Edwards on 27/02/2018.
//  Copyright © 2018 Blair Edwards. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene
{
    var background: SKEmitterNode!
    var player: SKSpriteNode!
    var exit: SKSpriteNode!
    var lifeMeter: SKSpriteNode!
    var healthPowerup: SKSpriteNode!
    
    override func didMove (to view: SKView)
    {
        //  Initialise background
        background = SKEmitterNode (fileNamed: "backgroundSmoke.sks")
        background .position = CGPoint (x: 0, y: 0)
        background .zPosition = -1
        self .addChild (background)
        
        //  Initialise player
        player = SKSpriteNode (imageNamed: "shuttle")
        player .position = CGPoint (x: 0, y: 0)
        self .addChild (player)
    }
    
    override func update (_ currentTime: TimeInterval)
    {
        // Called before each frame is rendered
    }
}
