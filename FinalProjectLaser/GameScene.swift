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
    //MAKR: - Categories
    let noCategory:UInt32 = 0
    let bulletLeftCategory:UInt32 = 0b1
    let bulletUpCategory:UInt32 = 0b1 << 1
    let leftButtonCategory:UInt32 = 0b1 << 2
    let leftLaserCategory:UInt32 = 0b1 << 3
    //MAKR: - node Properties
    var bulletLeft:SKSpriteNode?
    var bulletUp:SKSpriteNode?
    var leftButton:SKSpriteNode?
    var leftLaser:SKSpriteNode?
    var leftModel:SKSpriteNode?
}

extension GameScene{
    
    override func didMove(to view: SKView) {
        
        //Background Music
        setBackgroundMusic(atScene: self, fileName: "Elektronomia - Sky High.mp3")
        
        //physicls world delegate
        self.physicsWorld.contactDelegate = self
        
        //node set up functions
        leftBulletSetUp()
        bulletupSetup()
        leftBulletSetUp()
        leftLasersSetUp()
        leftModelSetUp()
        laserInitialPosition()
        
        
        let laserDestination:CGPoint = CGPoint(x: -(self.frame.width / 2), y: -(self.frame.height / 2))
        let moveLaserAction:SKAction = SKAction.move(to: laserDestination, duration: 3)
        leftModel?.run(moveLaserAction)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func update(_ currentTime: TimeInterval) {
    }
}

//MAKR: - nodes set up fuctions
extension GameScene{
    
    func leftBulletSetUp()
    {
        bulletLeft = self.childNode(withName: "bulletLeft") as? SKSpriteNode
        bulletLeft?.physicsBody?.categoryBitMask = bulletLeftCategory
        bulletLeft?.physicsBody?.collisionBitMask = noCategory
        bulletLeft?.physicsBody?.contactTestBitMask = leftButtonCategory
        //        bulletLeft?.physicsBody = SKPhysicsBody(rectangleOf: (bulletLeft?.size)!)
        bulletLeft?.physicsBody?.affectedByGravity = false
        bulletLeft?.physicsBody?.isDynamic = true
        bulletLeft?.physicsBody?.velocity = CGVector(dx: -100, dy: 0)
    }
    
    func bulletupSetup()
    {
        bulletUp = self.childNode(withName: "bulletUp") as? SKSpriteNode
        bulletUp?.physicsBody?.categoryBitMask = bulletUpCategory
        bulletUp?.physicsBody?.collisionBitMask = noCategory
        bulletUp?.physicsBody?.contactTestBitMask = leftLaserCategory
        //        bulletUp?.physicsBody = SKPhysicsBody(rectangleOf: (bulletUp?.size)!)
        bulletUp?.physicsBody?.affectedByGravity = false
        bulletUp?.physicsBody?.isDynamic = true
        bulletUp?.physicsBody?.velocity = CGVector(dx: 0, dy: 200)
    }
    
    func leftButtonSetUp()
    {
        leftButton = self.childNode(withName: "leftButton") as? SKSpriteNode
        leftButton?.physicsBody?.categoryBitMask = leftButtonCategory
        leftButton?.physicsBody?.collisionBitMask = noCategory
        leftButton?.physicsBody?.contactTestBitMask = bulletLeftCategory
        //        leftButton?.physicsBody = SKPhysicsBody(rectangleOf: (leftButton?.size)!)
        leftButton?.physicsBody?.isDynamic = true
    }
    func leftLasersSetUp ()
    {
        leftLaser = self.childNode(withName: "leftModel")?.childNode(withName: "leftLaser") as? SKSpriteNode
        leftLaser?.physicsBody?.categoryBitMask = leftLaserCategory
        leftLaser?.physicsBody?.collisionBitMask = noCategory
        leftLaser?.physicsBody?.contactTestBitMask = bulletUpCategory
        //        leftLaser?.physicsBody? = SKPhysicsBody(rectangleOf: (leftLaser?.size)!)
        leftLaser?.physicsBody?.isDynamic = true
    }
    
    func leftModelSetUp()
    {
        leftModel = self.childNode(withName: "leftModel") as? SKSpriteNode
    }
    

}

//MARK: - physics contact delegate
extension GameScene{
    
    func didBegin(_ contact: SKPhysicsContact)
    {
        print("contact")
        let categoryA:UInt32 = contact.bodyA.categoryBitMask
        let categoryB:UInt32 = contact.bodyB.categoryBitMask
        
        if categoryA == bulletLeftCategory || categoryB == bulletLeftCategory
        {
            let otherNode:SKSpriteNode = (categoryA == bulletLeftCategory) ? contact.bodyB.node as! SKSpriteNode : contact.bodyA.node as! SKSpriteNode
            bulletLeftDidHitButton(with: otherNode)
        }
        else if categoryA == leftLaserCategory || categoryB == leftLaserCategory
            {
                let otherNode:SKSpriteNode = (categoryA == leftLaserCategory) ? contact.bodyB.node as! SKSpriteNode : contact.bodyA.node as! SKSpriteNode
                bulletUpDidHitLaser(with: otherNode)
            }
    }
    
    //helper functions
    func bulletLeftDidHitButton(with other:SKSpriteNode)
    {
        other.color = UIColor.brown
        other.physicsBody?.isDynamic = false
        leftLaser?.removeFromParent()
    }
    
    func bulletUpDidHitLaser(with other:SKSpriteNode)
    {
        other.removeFromParent()
    }

}

//MARK: - functions
extension GameScene {
    
    func laserInitialPosition(){
        leftModel?.position = CGPoint(x: (-self.frame.width / 2) + ((leftModel?.frame.width)! / 2), y: (self.frame.height / 2) + ((leftModel?.frame.height)!/2))
    }
    
    func setBackgroundMusic(atScene:SKScene, fileName:String)
    {
        let bgm:SKAudioNode = SKAudioNode(fileNamed: fileName)
        bgm.autoplayLooped = true
        atScene.addChild(bgm)
    }
    
}




