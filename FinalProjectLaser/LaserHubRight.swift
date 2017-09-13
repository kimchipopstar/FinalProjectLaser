//
//  LaserHubRight.swift
//  FinalProjectLaser
//
//  Created by Tye Blackie on 2017-09-12.
//  Copyright © 2017 Jaewon Kim. All rights reserved.
//

import Foundation

import SpriteKit
import GameplayKit

class LaserHubRight: SKSpriteNode {
    
    var laserBeamRight = LaserBeamRight()
    
    init() {
        
        let laserHubTexture = SKTexture(imageNamed: "LaserHubRightGreen")
        super.init(texture: laserHubTexture, color: UIColor.clear, size: laserHubTexture.size())
        
        name = "rightLaser"
        zPosition = 1
        setScale(0.27)
        position = CGPoint(x: 320, y: 700)
        physicsBody = SKPhysicsBody(rectangleOf: CGSize.init(width: 40, height: 50), center: CGPoint.init(x: -10, y: -15))
//        physicsBody = SKPhysicsBody(texture: laserHubTexture, size:size)
        physicsBody?.categoryBitMask = CategoryEnum.laserHubCategory.rawValue
        physicsBody?.collisionBitMask = CategoryEnum.noCategory.rawValue
        physicsBody?.contactTestBitMask = CategoryEnum.smallBallCategory.rawValue
        physicsBody?.affectedByGravity = false
        physicsBody?.isDynamic = false
        
        addChild(laserBeamRight)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
