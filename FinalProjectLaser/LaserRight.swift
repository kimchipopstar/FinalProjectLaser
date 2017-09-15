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
    
    var laserHubRight:SKSpriteNode = LaserHubRight()
    
    static func moveLaser(scene:SKScene, hero:Hero) {
        
        scene.enumerateChildNodes(withName:"rightLaser")
        {
            (node, error) in
            
            node.position.y -= 8
            
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
