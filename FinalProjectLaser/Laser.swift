//
//  Laser.swift
//  FinalProjectLaser
//
//  Created by Jaewon Kim on 2017-09-11.
//  Copyright © 2017 Jaewon Kim. All rights reserved.
//

import Foundation

import SpriteKit
import GameplayKit

class Laser: SKSpriteNode {
    
    var laserHub:SKSpriteNode = LaserHub()

    static func moveLaser(scene:SKScene) {
            
        scene.enumerateChildNodes(withName:"laser")
        {
            (node, error) in
            
            node.position.y -= 6
            
        }
    }
    
    static func removeExessLasers(scene:SKScene) {
        
        for temp in scene.children {
            if temp.name == "laser" && temp.position.y < -700 {
                temp.removeFromParent()
                print(temp.position.y)
            }
        }
    }
}
