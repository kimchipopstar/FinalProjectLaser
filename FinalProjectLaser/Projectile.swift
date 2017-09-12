//
//  Projectile.swift
//  FinalProjectLaser
//
//  Created by Jaewon Kim on 2017-09-12.
//  Copyright © 2017 Jaewon Kim. All rights reserved.
//

import SpriteKit
import GameplayKit

class Projecttile: SKSpriteNode {
    
    init(){
        
        let projectileTexture = SKTexture(imageNamed: "SoccerBall")
        super.init(texture: projectileTexture, color: UIColor.clear, size: projectileTexture.size())
        
        position = position
        size = CGSize(width: 30, height: 30)
        physicsBody = SKPhysicsBody(circleOfRadius: self.size.width / 2)
        smallBall.physicsBody?.affectedByGravity = true
        smallBall.zPosition = 3
        smallBall.name = "SmallBall"
        smallBall.physicsBody?.categoryBitMask = CategoryEnum.smallBallCategory.rawValue
        //            smallBall.physicsBody?.collisionBitMask  = noCategory
        smallBall.physicsBody?.contactTestBitMask = CategoryEnum.laserBeamCategory.rawValue | CategoryEnum.laserHubCategory.rawValue
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



//class LaserBeam: SKSpriteNode {
//    
//    
//    init() {
//        
//        let laserBeamTexture = SKTexture(imageNamed: "LaserBeam")
//        super.init(texture: laserBeamTexture, color: UIColor.clear, size: laserBeamTexture.size())
//        
//        
//        zPosition = 2
//        size.width = 1320
//        position = CGPoint(x: 670, y: 80)
//        physicsBody = SKPhysicsBody(texture: laserBeamTexture, size: size)
//        physicsBody?.categoryBitMask = CategoryEnum.laserBeamCategory.rawValue
//        physicsBody?.collisionBitMask = CategoryEnum.noCategory.rawValue
//        physicsBody?.contactTestBitMask = CategoryEnum.smallBallCategory.rawValue | CategoryEnum.heroCategory.rawValue
//        physicsBody?.affectedByGravity = false
//        physicsBody?.isDynamic = false
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
