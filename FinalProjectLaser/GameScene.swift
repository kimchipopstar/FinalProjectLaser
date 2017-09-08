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
//    let leftButtonCategory:UInt32 = 0b1 << 2
//    let leftLaserCategory:UInt32 = 0b1 << 3
    let laserHubCategory:UInt32 = 0b1 << 2
    let laserBeamCategory:UInt32 = 0b1 << 3
    
    
    
    //MAKR: - node Properties
    var bulletLeft:SKSpriteNode?
    var bulletUp:SKSpriteNode?
//    var leftButton:SKSpriteNode?
//    var leftLaser:SKSpriteNode?
//    var leftModel:SKSpriteNode?
    
    var laserHub:SKSpriteNode?
    var laserBeam:SKSpriteNode?
    
    var Hero = SKSpriteNode(imageNamed: “Laser”)
    var background = SKSpriteNode()
}

extension GameScene{
    
    override func didMove(to view: SKView) {
        
        //Background Music
        setBackgroundMusic(atScene: self, fileName: "Elektronomia - Sky High.mp3")
        
        //physicls world delegate
        self.physicsWorld.contactDelegate = self
        
        //node set up functions
//        leftButtonSetUp()
        bulletupSetup()
        leftBulletSetUp()
//        leftLasersSetUp()
//        leftModelSetUp()
        laserHubSetUp()
        laserBeamSetUp()

//        laserInitialPosition()
        
//        let laserDestination:CGPoint = CGPoint(x: -(self.frame.width / 2), y: -(self.frame.height / 2))
//        let moveLaserAction:SKAction = SKAction.move(to: laserDestination, duration: 3)
//        laserHub?.run(moveLaserAction)
        
//        leftModel?.run(moveLaserAction)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func update(_ currentTime: TimeInterval) {
    }
}

//MAKR: - nodes set up fuctions
extension GameScene{
    
    func laserHubSetUp()
    {
        laserHub = SKSpriteNode(imageNamed: "LaserHub")
        laserHub?.setScale(0.5)
        self.addChild(laserHub!)
//        laserHub = self.childNode(withName: "laserHub") as? SKSpriteNode
//        laserHub?.physicsBody?.categoryBitMask = laserHubCategory
//        laserHub?.physicsBody?.collisionBitMask = noCategory
//        laserHub?.physicsBody?.contactTestBitMask = bulletLeftCategory
//        laserHub?.physicsBody?.affectedByGravity = false
//        laserHub?.physicsBody?.isDynamic = true
    }
    
    func laserBeamSetUp()
    {
        laserBeam = SKSpriteNode(imageNamed: "LaserBeam")
        laserBeam?.setScale(1.5)
        laserBeam?.position = CGPoint(x: -(self.frame.width / 2) - (laserBeam.frame.width / 2), y: (self.frame.height / 2) - (laserBeam?.frame.height / 2))
        
        
        laserHub?.addChild(laserBeam!)
//        laserBeam = self.childNode(withName: "laserHub")?.childNode(withName: "laserBeam") as? SKSpriteNode
//        laserBeam?.physicsBody?.categoryBitMask = laserBeamCategory
//        laserBeam?.physicsBody?.collisionBitMask = noCategory
//        laserBeam?.physicsBody?.contactTestBitMask = bulletUpCategory
//        laserBeam?.physicsBody?.affectedByGravity = false
//        laserBeam?.physicsBody?.isDynamic = true
    }
    
    func leftBulletSetUp()
    {
        bulletLeft = self.childNode(withName: "bulletLeft") as? SKSpriteNode
        bulletLeft?.physicsBody?.categoryBitMask = bulletLeftCategory
        bulletLeft?.physicsBody?.collisionBitMask = noCategory
        bulletLeft?.physicsBody?.contactTestBitMask = laserHubCategory
        //        bulletLeft?.physicsBody = SKPhysicsBody(rectangleOf: (bulletLeft?.size)!)
//        bulletLeft?.physicsBody?.affectedByGravity = false
//        bulletLeft?.physicsBody?.isDynamic = true
        bulletLeft?.physicsBody?.velocity = CGVector(dx: -100, dy: 0)
    }
    
    func bulletupSetup()
    {
        bulletUp = self.childNode(withName: "bulletUp") as? SKSpriteNode
        bulletUp?.physicsBody?.categoryBitMask = bulletUpCategory
        bulletUp?.physicsBody?.collisionBitMask = noCategory
        bulletUp?.physicsBody?.contactTestBitMask = laserBeamCategory
        //        bulletUp?.physicsBody = SKPhysicsBody(rectangleOf: (bulletUp?.size)!)
        bulletUp?.physicsBody?.affectedByGravity = false
        bulletUp?.physicsBody?.isDynamic = true
        bulletUp?.physicsBody?.velocity = CGVector(dx: 0, dy: 200)
    }
    
//    func leftButtonSetUp()
//    {
//        leftButton = self.childNode(withName: "leftButton") as? SKSpriteNode
//        leftButton?.physicsBody?.categoryBitMask = leftButtonCategory
//        leftButton?.physicsBody?.collisionBitMask = noCategory
//        leftButton?.physicsBody?.contactTestBitMask = bulletLeftCategory
//        //        leftButton?.physicsBody = SKPhysicsBody(rectangleOf: (leftButton?.size)!)
//        leftButton?.physicsBody?.isDynamic = true
//    }
//    func leftLasersSetUp ()
//    {
//        leftLaser = self.childNode(withName: "leftModel")?.childNode(withName: "leftLaser") as? SKSpriteNode
//        leftLaser?.physicsBody?.categoryBitMask = leftLaserCategory
//        leftLaser?.physicsBody?.collisionBitMask = noCategory
//        leftLaser?.physicsBody?.contactTestBitMask = bulletUpCategory
//        //        leftLaser?.physicsBody? = SKPhysicsBody(rectangleOf: (leftLaser?.size)!)
//        leftLaser?.physicsBody?.isDynamic = true
//    }
//    
//    func leftModelSetUp()
//    {
//        leftModel = self.childNode(withName: "leftModel") as? SKSpriteNode
//    }
    

}

//MARK: - physics contact delegate
extension GameScene{
    
    func didBegin(_ contact: SKPhysicsContact)
    {
        
        let categoryA:UInt32 = contact.bodyA.categoryBitMask
        let categoryB:UInt32 = contact.bodyB.categoryBitMask
        
        if categoryA == bulletLeftCategory || categoryB == bulletLeftCategory
        {
            let otherNode:SKSpriteNode = (categoryA == bulletLeftCategory) ? contact.bodyB.node as! SKSpriteNode : contact.bodyA.node as! SKSpriteNode
            bulletLeftDidHitButton(with: otherNode)
            print("contactHub")
        }
        else if categoryA == laserBeamCategory || categoryB == laserBeamCategory
            {
                let otherNode:SKSpriteNode = (categoryA == laserBeamCategory) ? contact.bodyB.node as! SKSpriteNode : contact.bodyA.node as! SKSpriteNode
                bulletUpDidHitLaser(with: otherNode)
                print("contactLaser")
            }
    }
    
    //helper functions
    func bulletLeftDidHitButton(with other:SKSpriteNode)
    {
//        other.color = UIColor.brown
        other.physicsBody?.isDynamic = false
        laserBeam?.removeFromParent()
    }
    
    func bulletUpDidHitLaser(with other:SKSpriteNode)
    {
        other.removeFromParent()
    }

}

//MARK: - functions
extension GameScene {
    
    func laserInitialPosition(){
        laserHub?.position = CGPoint(x: (-self.frame.width / 2) + ((laserHub?.frame.width)! / 2), y: (self.frame.height / 2) + ((laserHub?.frame.height)!/2))
    }
    
    func setBackgroundMusic(atScene:SKScene, fileName:String)
    {
        let bgm:SKAudioNode = SKAudioNode(fileNamed: fileName)
        bgm.autoplayLooped = true
        atScene.addChild(bgm)
    }
    
}




