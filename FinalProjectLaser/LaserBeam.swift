//
//  LaserBeam.swift
//  FinalProjectLaser
//
//  Created by Tye Blackie on 2017-09-11.
//  Copyright © 2017 Jaewon Kim. All rights reserved.
//

import Foundation

import SpriteKit
import GameplayKit

class LaserBeam: SKSpriteNode {

    init() {
        
        let laserBeamTexture = SKTexture(imageNamed: "LaserBeam")
        super.init(texture: laserBeamTexture, color: UIColor.clear, size: laserBeamTexture.size())
        
        if let sparks = SKEmitterNode(fileNamed: "LeftLaserSpark") {
        sparks.particleSize = CGSize(width: 0, height: 0)
        sparks.position = CGPoint(x: 1200, y: 0)
        sparks.zPosition = 3
        sparks.isHidden = false
        self.addChild(sparks)
            
            if let laser = SKEmitterNode(fileNamed: "LaserBeamFX") {
                laser.particleSize = CGSize(width: 0, height: 0)
                laser.position = CGPoint(x: 0, y: 0)
                laser.zPosition = 3
                laser.isHidden = false
                self.addChild(laser)
            }
            
            if let smoke = SKEmitterNode(fileNamed: "LaserBeamSmoke") {
                smoke.particleSize = CGSize(width: 0, height: 0)
                smoke.position = CGPoint(x: 1200, y: 0)
                smoke.zPosition = 3
                smoke.isHidden = false
                self.addChild(smoke)
            }
            
        
        }
        
        
        zPosition = 2
        size.width = 2380
        size.height = 60
        position = CGPoint(x: 1230, y: 155)
        physicsBody = SKPhysicsBody(texture: laserBeamTexture, size: size)
        physicsBody?.categoryBitMask = CategoryEnum.laserBeamCategory.rawValue
        physicsBody?.collisionBitMask = CategoryEnum.noCategory.rawValue
        physicsBody?.contactTestBitMask =  CategoryEnum.heroCategory.rawValue  | CategoryEnum.projectileCategory.rawValue
        physicsBody?.affectedByGravity = false
        physicsBody?.isDynamic = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
