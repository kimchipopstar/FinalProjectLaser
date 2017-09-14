//
//  LivesLabel.swift
//  FinalProjectLaser
//
//  Created by Jaewon Kim on 2017-09-13.
//  Copyright © 2017 Jaewon Kim. All rights reserved.
//

import SpriteKit
import GameplayKit

class LivesLabel: SKLabelNode {
    
    
    override init() {
        super.init()
        text = "Lives: 3"
        fontSize = 70
        fontColor = SKColor.white
        horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        position = CGPoint(x: -350, y: -600)
        zPosition = 100
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


