//
//  Projectile.swift
//  FinalProjectLaser
//
//  Created by Jaewon Kim on 2017-09-12.
//  Copyright © 2017 Jaewon Kim. All rights reserved.
//

import SpriteKit
import GameplayKit

class Projectile: SKSpriteNode {
    
    init(){
        let projectileTexture = SKTexture(imageNamed: "CannonProjectile2")
        super.init(texture: projectileTexture, color: UIColor.clear, size: projectileTexture.size())
        
        position = CGPoint(x: 0, y: -600)
        size = CGSize(width: 55, height: 55)
        physicsBody = SKPhysicsBody(circleOfRadius: self.size.width / 2.8)
        physicsBody?.affectedByGravity = true
        zPosition = 3
        physicsBody?.categoryBitMask = CategoryEnum.projectileCategory.rawValue
        physicsBody?.collisionBitMask  = CategoryEnum.projectileCategory.rawValue
        physicsBody?.contactTestBitMask = CategoryEnum.laserBeamCategory.rawValue | CategoryEnum.laserHubCategory.rawValue
        name = "projectile"
      
        if let projectileParticle = SKEmitterNode(fileNamed: "ProjectileFire") {
            projectileParticle.particleSize = CGSize(width: 0, height: 0)
            projectileParticle.position = CGPoint(x: 0, y: 0)
            projectileParticle.zPosition = 3
            projectileParticle.isHidden = false
            self.addChild(projectileParticle)
        }
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

