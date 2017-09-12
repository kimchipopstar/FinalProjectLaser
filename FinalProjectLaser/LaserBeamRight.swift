//
//  LaserBeamRight.swift
//  FinalProjectLaser
//
//  Created by Tye Blackie on 2017-09-12.
//  Copyright © 2017 Jaewon Kim. All rights reserved.
//

import Foundation

import SpriteKit
import GameplayKit

class LaserBeamRight: SKSpriteNode {
    
    init() {
        
        let laserBeamTexture = SKTexture(imageNamed: "LaserBeam")
        super.init(texture: laserBeamTexture, color: UIColor.clear, size: laserBeamTexture.size())
        
        zPosition = 2
        size.width = 2380
        size.height = 60
        position = CGPoint(x: -1230, y: 155)
        physicsBody = SKPhysicsBody(texture: laserBeamTexture, size: size)
        physicsBody?.categoryBitMask = CategoryEnum.laserBeamCategory.rawValue
        physicsBody?.collisionBitMask = CategoryEnum.noCategory.rawValue
        physicsBody?.contactTestBitMask = CategoryEnum.smallBallCategory.rawValue | CategoryEnum.heroCategory.rawValue
        physicsBody?.affectedByGravity = false
        physicsBody?.isDynamic = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
