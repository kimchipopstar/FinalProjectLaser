//
//  Laser.swift
//  FinalProjectLaser
//
//  Created by Jaewon Kim on 2017-09-11.
//  Copyright © 2017 Jaewon Kim. All rights reserved.
//

import Foundation

import SpriteKit
import GameplayKit

class Laser: SKSpriteNode {
    
    var laserHub:SKSpriteNode = SKSpriteNode()
    var laserBeam:SKSpriteNode = SKSpriteNode()
    let laserHubTexture = SKTexture(imageNamed: "LaserHub")
    let laserBeamTexture = SKTexture(imageNamed: "LaserBeam")
    
    func laserSetUp()
    {
        laserHubSetUp()
        laserBeamSetUp()
    }
    
    func laserHubSetUp()
    {
        laserHub = SKSpriteNode(imageNamed: "LaserHub")
        laserHub.zPosition = 1
        laserHub.setScale(0.5)
        laserHub.position = CGPoint(x: -320, y: 0)
        laserHub.physicsBody = SKPhysicsBody(texture: laserHubTexture, size:laserHub.size)
        laserHub.physicsBody?.categoryBitMask = CategoryEnum.laserHubCategory.rawValue
        laserHub.physicsBody?.collisionBitMask = CategoryEnum.noCategory.rawValue
        laserHub.physicsBody?.contactTestBitMask = CategoryEnum.smallBallCategory.rawValue
        laserHub.physicsBody?.affectedByGravity = false
        laserHub.physicsBody?.isDynamic = false
        self.addChild(laserHub)
        
        
    }
    
    func laserBeamSetUp()
    {
        laserBeam = SKSpriteNode(imageNamed: "LaserBeam")
        laserBeam.zPosition = 2
        laserBeam.size.width = 1320
        laserBeam.position = CGPoint(x: 670, y: 80)
        laserBeam.physicsBody = SKPhysicsBody(texture: laserBeamTexture, size: laserBeam.size)
        laserBeam.physicsBody?.categoryBitMask = CategoryEnum.laserBeamCategory.rawValue
        laserBeam.physicsBody?.collisionBitMask = CategoryEnum.noCategory.rawValue
        laserBeam.physicsBody?.contactTestBitMask = CategoryEnum.smallBallCategory.rawValue | CategoryEnum.heroCategory.rawValue
        laserBeam.physicsBody?.affectedByGravity = false
        laserBeam.physicsBody?.isDynamic = false
        laserHub.addChild(laserBeam)
        
        
    }
    
}
