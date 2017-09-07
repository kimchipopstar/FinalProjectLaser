//
//  GameScene.swift
//  FinalProjectLaser
//
//  Created by Jaewon Kim on 2017-09-05.
//  Copyright © 2017 Jaewon Kim. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var testObject:SKSpriteNode?
    var testLaser:SKSpriteNode?
    var testButton:SKSpriteNode?
    let noCategory:UInt32 = 0
    let objectCategory:UInt32 = 0b1
    let laserCategory:UInt32 = 0b1 << 1
    let buttonCategory:UInt32 = 0b1 << 2

    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
        //Background Music
        let bgm:SKAudioNode = SKAudioNode(fileNamed: "Elektronomia - Sky High.mp3")
        bgm.autoplayLooped = true
        self.addChild(bgm)
        
//        let myShip:SKSpriteNode = self.childNode(withName: "ship") as! SKSpriteNode
//        myShip.xScale = 0.5
//        myShip.yScale = 0.5
        
//        let player:SKSpriteNode = SKSpriteNode(imageNamed: "Spaceship")
//        self.addChild(player)
//        player.position = CGPoint(x:100, y:100)
        
        testObject = self.childNode(withName: "testObject") as? SKSpriteNode
        testObject?.physicsBody?.categoryBitMask = objectCategory
        testObject?.physicsBody?.collisionBitMask = noCategory
        testObject?.physicsBody?.contactTestBitMask = laserCategory
        
        testLaser = self.childNode(withName: "testLaser") as? SKSpriteNode
        testLaser?.physicsBody?.categoryBitMask = laserCategory
        testLaser?.physicsBody?.collisionBitMask = noCategory
        testLaser?.physicsBody?.contactTestBitMask = objectCategory
        
        testButton = self.childNode(withName: "testButton") as? SKSpriteNode
        testButton?.physicsBody?.categoryBitMask = buttonCategory
        testButton?.physicsBody?.collisionBitMask = noCategory
        testButton?.physicsBody?.contactTestBitMask = objectCategory
        
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        let cA:UInt32 = contact.bodyA.categoryBitMask
        let cB:UInt32 = contact.bodyB.categoryBitMask
        if cA == objectCategory || cB == objectCategory{
            let otherNode:SKNode = (cA == objectCategory) ? contact.bodyB.node! : contact.bodyA.node!
            objectDidCollide(with: otherNode as! SKSpriteNode)
        }  else{
            contact.bodyA.node?.removeFromParent()
        }
        
//        contact.bodyB.node?.removeFromParent()
    }
    
    func objectDidCollide(with other:SKSpriteNode){
        let otherCategory = other.physicsBody?.categoryBitMask
        if otherCategory == buttonCategory{
            testButton?.color = UIColor.blue
        }
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    func createLasers(){
    
    
    }
    
}
