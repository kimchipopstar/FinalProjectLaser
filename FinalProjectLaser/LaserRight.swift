//
//  LaserRight.swift
//  FinalProjectLaser
//
//  Created by Tye Blackie on 2017-09-12.
//  Copyright © 2017 Jaewon Kim. All rights reserved.
//

import Foundation

import SpriteKit
import GameplayKit

class LaserRight: SKSpriteNode {
    
    static var rightLaserMovementSpeed: CGFloat = 4.0
    var laserHubRight:SKSpriteNode = LaserHubRight()
    
    static func rightLaserSpeedIncrease() {
        self.rightLaserMovementSpeed = self.rightLaserMovementSpeed * 1.2
    }
    
    static func moveLaser(scene:SKScene, hero:Hero) {
        
        scene.enumerateChildNodes(withName:"rightLaser")
        {
            (node, error) in
            
            node.position.y -= self.rightLaserMovementSpeed
        }
    }
    
    static func removeExessLasers(scene:SKScene) {
        
        for temp in scene.children {
            if temp.name == "rightLaser" && temp.position.y < -700 {
                temp.removeFromParent()
                print(temp.position.y)
            }
        }
    }
}
