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
    let laserHubCategory:UInt32 = 0b1 << 2
    let laserBeamCategory:UInt32 = 0b1 << 3

    //MAKR: - node Properties
    var bulletLeft:SKSpriteNode?
    var bulletUp:SKSpriteNode?
    
    var laserHub:SKSpriteNode?
    var laserBeam:SKSpriteNode?
    
    var Hero = SKSpriteNode(imageNamed: "Laser")
    var background = SKSpriteNode()
}

extension GameScene{
    
    override func didMove(to view: SKView) {
        
        //Background Music
        setBackgroundMusic(atScene: self, fileName: "Elektronomia - Sky High.mp3")
        
        //physicls world delegate
        self.physicsWorld.contactDelegate = self
        
        //node set up functions
        laserHubSetUp()
        laserBeamSetUp()

//        laserInitialPosition()
        
//        let laserDestination:CGPoint = CGPoint(x: -(self.frame.width / 2), y: -(self.frame.height / 2))
//        let moveLaserAction:SKAction = SKAction.move(to: laserDestination, duration: 3)
//        laserHub?.run(moveLaserAction)
        
//        leftModel?.run(moveLaserAction)
        
        let border = self.childNode(withName: "BorderSprite")
        
        Hero.size = CGSize(width: 200, height: 200)
        Hero.position = CGPoint(x: 0, y: -600)
        Hero.zPosition = 4
        
        self.addChild(Hero)
        
        createBackgrounds()
        
        
        let borderFrame = SKPhysicsBody(edgeLoopFrom: (border?.frame)!)
        borderFrame.friction = 0
        borderFrame.restitution = 1
        self.physicsBody = borderFrame
        
        
    }
    override func update(_ currentTime: TimeInterval) {
        
        moveBackgrounds()
        
        removeExessProjectiles()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in (touches ) {
            let location = touch.location(in: self)
            
            let SmallBall = SKSpriteNode(imageNamed: "Projectile1")
            SmallBall.position = Hero.position
            SmallBall.size = CGSize(width: 30, height: 30)
            SmallBall.physicsBody = SKPhysicsBody(circleOfRadius: SmallBall.size.width / 2)
            SmallBall.physicsBody?.affectedByGravity = true
            SmallBall.zPosition = 3
            SmallBall.name = "SmallBall"
            
            self.addChild(SmallBall)
            
            var dx = CGFloat(location.x - Hero.position.x)
            var dy = CGFloat(location.y - Hero.position.y)
            
            let magnitude = sqrt(dx * dx + dy * dy)
            
            dx /= magnitude
            dy /= magnitude
            
            let vector = CGVector(dx: 60.0 * dx, dy: 60.0 * dy)
            
            SmallBall.physicsBody?.applyImpulse(vector)
            
        }
    }
}

//MAKR: - nodes set up fuctions
extension GameScene{
    
    func laserHubSetUp()
    {
        laserHub = SKSpriteNode(imageNamed: "LaserHub")
        laserHub?.zPosition = 1
        laserHub?.setScale(0.5)
        laserHub?.position = CGPoint(x: -320, y: 0)
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
        laserBeam?.zPosition = 2
        laserBeam?.size.width = 1250
        laserBeam?.position = CGPoint(x: 650, y: 80)
        laserHub?.addChild(laserBeam!)
//        laserBeam = self.childNode(withName: "laserHub")?.childNode(withName: "laserBeam") as? SKSpriteNode
//        laserBeam?.physicsBody?.categoryBitMask = laserBeamCategory
//        laserBeam?.physicsBody?.collisionBitMask = noCategory
//        laserBeam?.physicsBody?.contactTestBitMask = bulletUpCategory
//        laserBeam?.physicsBody?.affectedByGravity = false
//        laserBeam?.physicsBody?.isDynamic = true
    }

    

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
    
    func removeExessProjectiles() {
        
        for temp in self.children {
            if temp.name == "SmallBall" && temp.position.y < -600 {
                temp.removeFromParent()
                print(temp.position.y)
            }
        }
    }
    
    func createBackgrounds() {
        
        for i in 0...3 {
            
            let background = SKSpriteNode(imageNamed: "LaserTunnel")
            background.name = "Background"
            background.size = CGSize(width: (self.scene?.size.width)!, height: 1000)
            background.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            background.position = CGPoint(x: 0, y: CGFloat(i) * background.size.height)
            background.zPosition = 0
            
            self.addChild(background)
        }
    }
    
    func moveBackgrounds() {
        
        self.enumerateChildNodes(withName:"Background")
            {
                (node, error) in
                
                node.position.y -= 3
                
                if node.position.y < -((self.scene?.size.height)!)
                {
                    node.position.y += (self.scene?.size.height)! * 3
                }
        }
    }
    
}




