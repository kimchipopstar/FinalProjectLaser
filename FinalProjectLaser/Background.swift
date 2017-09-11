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
//    
//    var background:SKSpriteNode = SKSpriteNode()
    
    func createBackgrounds(scene:SKScene) {
        
        for i in 0...3 {
            
            
            let background = SKSpriteNode(imageNamed: "LaserTunnel")
            background.name = "Background"
            background.size = CGSize(width: (scene.scene?.size.width)!, height: 1000)
            background.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            background.position = CGPoint(x: 0, y: CGFloat(i) * background.size.height)
            background.zPosition = 0
            
            scene.addChild(background)
        }
    }
    
    func moveBackgrounds(scene:SKScene) {
        
        scene.enumerateChildNodes(withName:"Background")
        {
            (node, error) in
            
            node.position.y -= 3
            
            if node.position.y < -((scene.scene?.size.height)!)
            {
                node.position.y += (scene.scene?.size.height)! * 3
            }
        }
    }
}
