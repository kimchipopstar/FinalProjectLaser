//
//  LaserHub.swift
//  FinalProjectLaser
//
//  Created by Tye Blackie on 2017-09-11.
//  Copyright © 2017 Jaewon Kim. All rights reserved.
//

import Foundation

import SpriteKit
import GameplayKit

class LaserHub: SKSpriteNode {
    
    var laserBeam = LaserBeam()

    init() {
        
        let laserHubTexture = SKTexture(imageNamed: "LaserHub")
        super.init(texture: laserHubTexture, color: UIColor.clear, size: laserHubTexture.size())
                
        name = "laser"
        zPosition = 1
        setScale(0.5)
        position = CGPoint(x: -320, y: 700)
        physicsBody = SKPhysicsBody(texture: laserHubTexture, size:size)
        physicsBody?.categoryBitMask = CategoryEnum.laserHubCategory.rawValue
        physicsBody?.collisionBitMask = CategoryEnum.noCategory.rawValue
        physicsBody?.contactTestBitMask = CategoryEnum.smallBallCategory.rawValue
        physicsBody?.affectedByGravity = false
        physicsBody?.isDynamic = false
        
        addChild(laserBeam)
    }
    

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
