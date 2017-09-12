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
        
        let projectileTexture = SKTexture(imageNamed: "SoccerBall")
        super.init(texture: projectileTexture, color: UIColor.clear, size: projectileTexture.size())
        
        position = CGPoint(x: 0, y: -600)
        size = CGSize(width: 30, height: 30)
        physicsBody = SKPhysicsBody(circleOfRadius: self.size.width / 2)
        physicsBody?.affectedByGravity = true
        zPosition = 3
        name = "SmallBall"
        physicsBody?.categoryBitMask = CategoryEnum.smallBallCategory.rawValue
        physicsBody?.collisionBitMask  = CategoryEnum.noCategory.rawValue
        physicsBody?.contactTestBitMask = CategoryEnum.laserBeamCategory.rawValue | CategoryEnum.laserHubCategory.rawValue
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

