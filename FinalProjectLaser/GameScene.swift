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
    


    let noCategory:UInt32 = 0
    let bulletLeftCategory:UInt32 = 0b1
    let bulletUpCategory:UInt32 = 0b1 << 1
    let leftButtonCategory:UInt32 = 0b1 << 2
    let leftLaserCategory:UInt32 = 0b1 << 3

    var bulletLeft:SKSpriteNode?
    var bulletUp:SKSpriteNode?
    var leftButton:SKSpriteNode?
    var leftLaser:SKSpriteNode?

    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
        //Background Music
        let bgm:SKAudioNode = SKAudioNode(fileNamed: "Elektronomia - Sky High.mp3")
        bgm.autoplayLooped = true
        self.addChild(bgm)
        
        bulletLeft = self.childNode(withName: "bulletLeft") as? SKSpriteNode
        bulletLeft?.physicsBody?.categoryBitMask = bulletLeftCategory
        bulletLeft?.physicsBody?.collisionBitMask = noCategory
        bulletLeft?.physicsBody?.contactTestBitMask = leftButtonCategory
//        bulletLeft?.physicsBody = SKPhysicsBody(rectangleOf: (bulletLeft?.size)!)
        bulletLeft?.physicsBody?.affectedByGravity = false
        bulletLeft?.physicsBody?.isDynamic = true
        bulletLeft?.physicsBody?.velocity = CGVector(dx: -100, dy: 0)
        
        
        
        bulletUp = self.childNode(withName: "bulletUp") as? SKSpriteNode
        bulletUp?.physicsBody?.categoryBitMask = bulletUpCategory
        bulletUp?.physicsBody?.collisionBitMask = noCategory
        bulletUp?.physicsBody?.contactTestBitMask = leftLaserCategory
//        bulletUp?.physicsBody = SKPhysicsBody(rectangleOf: (bulletUp?.size)!)
        bulletUp?.physicsBody?.affectedByGravity = false
        bulletUp?.physicsBody?.isDynamic = true
        bulletUp?.physicsBody?.velocity = CGVector(dx: 0, dy: 200)
        
        leftButton = self.childNode(withName: "leftButton") as? SKSpriteNode
        leftButton?.physicsBody?.categoryBitMask = leftButtonCategory
        leftButton?.physicsBody?.collisionBitMask = noCategory
        leftButton?.physicsBody?.contactTestBitMask = bulletLeftCategory
//        leftButton?.physicsBody = SKPhysicsBody(rectangleOf: (leftButton?.size)!)
        leftButton?.physicsBody?.isDynamic = true
        
        leftLaser = self.childNode(withName: "leftModel")?.childNode(withName: "leftLaser") as? SKSpriteNode
        leftLaser?.physicsBody?.categoryBitMask = leftLaserCategory
        leftLaser?.physicsBody?.collisionBitMask = noCategory
        leftLaser?.physicsBody?.contactTestBitMask = bulletUpCategory
//        leftLaser?.physicsBody? = SKPhysicsBody(rectangleOf: (leftLaser?.size)!)
        leftLaser?.physicsBody?.isDynamic = true

        


    }


    
    func didBegin(_ contact: SKPhysicsContact) {
        print("contact")
//        contact.bodyA.node.
        let categoryA:UInt32 = contact.bodyA.categoryBitMask
        let categoryB:UInt32 = contact.bodyB.categoryBitMask

            if categoryA == bulletLeftCategory || categoryB == bulletLeftCategory{
            let otherNode:SKSpriteNode = (categoryA == bulletLeftCategory) ? contact.bodyB.node as! SKSpriteNode : contact.bodyA.node as! SKSpriteNode
                bulletLeftDidHitButton(with: otherNode)
            } else if categoryA == leftLaserCategory || categoryB == leftLaserCategory{
                let otherNode:SKSpriteNode = (categoryA == leftLaserCategory) ? contact.bodyB.node as! SKSpriteNode : contact.bodyA.node as! SKSpriteNode
                bulletUpDidHitLaser(with: otherNode)
            }
        

        }
    


    func bulletLeftDidHitButton(with other:SKSpriteNode){
        other.color = UIColor.brown
        leftLaser?.removeFromParent()
    }
    
    func bulletUpDidHitLaser(with other:SKSpriteNode) {
        other.removeFromParent()
    }
    


    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    func createLasers(){
    
    
    }
    
}
