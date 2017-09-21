//
//  Background.swift
//  FinalProjectLaser
//
//  Created by Tye Blackie on 2017-09-11.
//  Copyright © 2017 Jaewon Kim. All rights reserved.
//

import SpriteKit
import GameplayKit

class Background: SKSpriteNode {
    
    var backgroundSpeed: CGFloat = 4.0
    
    func createBackgrounds(scene:SKScene) {
        
        for i in 0...3 {
            
        
            let background = SKSpriteNode(imageNamed: "LaserTunnel")
            background.name = "Background"
            background.size = CGSize(width: (scene.scene?.size.width)!, height: 1000)
            background.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            background.position = CGPoint(x: 0, y: (CGFloat(i) * background.size.height - 200))
            background.zPosition = 0
            
            scene.addChild(background)
        }
    }

    func backgroundSpeedIncrease() {
            self.backgroundSpeed = self.backgroundSpeed * 1.2
    }
    
    
    
    func moveBackgrounds(scene:SKScene, hero:Hero) {
        
        scene.enumerateChildNodes(withName:"Background")
        {
            (node, error) in
            
            node.position.y -= self.backgroundSpeed

            if node.position.y < -((scene.scene?.size.height)!)
            {
                node.position.y += ((scene.scene?.size.height)! - 5) * 3
            }
        }
    }
}
