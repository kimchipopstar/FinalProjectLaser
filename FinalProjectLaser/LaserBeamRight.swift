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
        
        if let sparks = SKEmitterNode(fileNamed: "RightLaserSpark") {
            sparks.particleSize = CGSize(width: 0, height: 0)
            sparks.position = CGPoint(x: -1200, y: 0)
            sparks.zPosition = 3
            sparks.isHidden = false
            self.addChild(sparks)
        }
        
        if let smokes = SKEmitterNode(fileNamed: "LaserBeamSomke"){
            smokes.zPosition = 2
            smokes.position = CGPoint(x: -1200, y: 0)
            smokes.isHidden = false
            self.addChild(smokes)
        }
        
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
        physicsBody?.pinned = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
