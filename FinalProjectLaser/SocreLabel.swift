//
//  SocreLabel.swift
//  FinalProjectLaser
//
//  Created by Jaewon Kim on 2017-09-13.
//  Copyright © 2017 Jaewon Kim. All rights reserved.
//

import SpriteKit
import GameplayKit

class ScoreLabel: SKLabelNode {
    
    override init() {
        super.init()
        text = "0"
        fontSize = 70
        fontColor = SKColor.white
        horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        position = CGPoint(x: 350, y: 600)
        zPosition = 100
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

