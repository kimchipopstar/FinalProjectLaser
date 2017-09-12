//
//  Hero.swift
//  FinalProjectLaser
//
//  Created by Jaewon Kim on 2017-09-11.
//  Copyright © 2017 Jaewon Kim. All rights reserved.
//

import SpriteKit
import GameplayKit

class Hero: SKSpriteNode {
    
    init() {
        let heroTexture:SKTexture = SKTexture(imageNamed: "Laser")
        super.init(texture: heroTexture, color: UIColor.clear, size: heroTexture.size())
        
        size = CGSize(width: 200, height: 200)
        position = CGPoint(x: 0, y: -600)
        zPosition = 4
        physicsBody = SKPhysicsBody(texture: heroTexture, size: size)
        physicsBody?.categoryBitMask = CategoryEnum.heroCategory.rawValue
        physicsBody?.collisionBitMask = CategoryEnum.noCategory.rawValue
        physicsBody?.contactTestBitMask = CategoryEnum.laserBeamCategory.rawValue
        physicsBody?.affectedByGravity = false
        physicsBody?.isDynamic = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func setUpHero()
//    {
//        size = CGSize(width: 200, height: 200)
//        position = CGPoint(x: 0, y: -600)
//        zPosition = 4
//        let heroTexture:SKTexture = 
//        physicsBody?.categoryBitMask = CategoryEnum.heroCategory.rawValue
//        physicsBody?.collisionBitMask = CategoryEnum.noCategory.rawValue
//        physicsBody?.contactTestBitMask = CategoryEnum.laserBeamCategory.rawValue
//        physicsBody?.affectedByGravity = false
//        physicsBody?.isDynamic = false
//    }
    
    func createProjectile() -> SKSpriteNode
    {
        return Projectile()
    }
    
    func launchTowards(location:CGPoint, spriteNode:SKSpriteNode)
    {
        var dx = CGFloat(location.x - position.x)
        var dy = CGFloat(location.y - position.y)
        
        let magnitude = sqrt(dx * dx + dy * dy)
        
        dx /= magnitude
        dy /= magnitude
        
        let vector = CGVector(dx: 60.0 * dx, dy: 60.0 * dy)
        
        spriteNode.physicsBody?.applyImpulse(vector)

    }
    
}
