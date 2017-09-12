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

    //MAKR: - node Properties
    var background:Background = Background()
    let hero:Hero = Hero(imageNamed: "Laser")
}

extension GameScene{
    
    override func didMove(to view: SKView) {
        
//        Background Music
//        setBackgroundMusic(atScene: self, fileName: "Elektronomia - Sky High.mp3")
        
        //physicls world delegate
        self.physicsWorld.contactDelegate = self
        view.showsPhysics = true
        

        
        
        
        // MARK: - HELLO
        
        
        func spawnLasers()
        {
            let laser = Laser()
            self.addChild(laser.laserHub)
        }
        
        func spawnRightLasers()
        {
            let rightLaser = LaserRight()
            self.addChild(rightLaser.laserHubRight)
        }
        
        
        let waitAction = SKAction.wait(forDuration: 6)
        let spawnLaserAction = SKAction.run(spawnLasers)
        let spawnRightLaserAction = SKAction.run(spawnRightLasers)
        let entireAction = SKAction.repeatForever(SKAction.sequence([spawnLaserAction, waitAction, spawnRightLaserAction, waitAction]))
        run(entireAction)
        
        hero.setUpHero()
        
        self.addChild(hero)
        

//        laserInitialPosition()
//        
//        let laserDestination:CGPoint = CGPoint(x: -(self.frame.width / 2), y: -(self.frame.height / 2))
//        let moveLaserAction:SKAction = SKAction.move(to: laserDestination, duration: 10)
//        laserHub.run(moveLaserAction)

        
        let border = self.childNode(withName: "BorderSprite")
        
        background.createBackgrounds(scene:self)
        
        let borderFrame = SKPhysicsBody(edgeLoopFrom: (border?.frame)!)
        borderFrame.friction = 0
        borderFrame.restitution = 1
        self.physicsBody = borderFrame
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        background.moveBackgrounds(scene:self)
        Laser.moveLaser(scene:self)
        LaserRight.moveLaser(scene:self)
        removeExessProjectiles()
        Laser.removeExessLasers(scene: self)
        LaserRight.removeExessLasers(scene: self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in (touches ) {
            let location = touch.location(in: self)
            

            let smallBall = hero.createProjectile()
            
            self.addChild(smallBall)
            
            hero.launchTowards(location: location, spriteNode:smallBall)
        }
    }
}

//MAKR: - nodes set up fuctions


//MARK: - physics contact delegate
extension GameScene{
    
    func didBegin(_ contact: SKPhysicsContact)
    {
        contactLogic(contact: contact)
    }
    
    func contactLogic(contact:SKPhysicsContact)
    {
        let categoryA:UInt32! = contact.bodyA.categoryBitMask
        let categoryB:UInt32! = contact.bodyB.categoryBitMask
        
        if categoryA == CategoryEnum.laserHubCategory.rawValue || categoryB == CategoryEnum.laserHubCategory.rawValue
        {
            if let laserNode = contact.bodyA.node as? LaserHub
            {
                laserNode.laserBeam.removeFromParent()
            }
            print("contactHub")
        }
        else if categoryA == CategoryEnum.laserBeamCategory.rawValue || categoryB == CategoryEnum.laserBeamCategory.rawValue
        {
            
            let otherNode:SKSpriteNode
            if categoryA == CategoryEnum.laserBeamCategory.rawValue
            {
                
                if let otherNode = contact.bodyB.node as? SKSpriteNode {
                    if otherNode.physicsBody?.categoryBitMask == CategoryEnum.smallBallCategory.rawValue
                    {
                        laserBeamContactBalls(with: otherNode)
                    }
                }
            }
            else
            {
                otherNode = contact.bodyA.node as! SKSpriteNode
                if otherNode.physicsBody?.categoryBitMask == CategoryEnum.smallBallCategory.rawValue
                {
                    laserBeamContactBalls(with: otherNode)
                }
            }
            //            let otherNode:SKSpriteNode = (categoryA == laserBeamCategory) ? contact.bodyB.node as! SKSpriteNode : contact.bodyA.node as! SKSpriteNode
            //            if otherNode.physicsBody?.categoryBitMask == smallBallCategory{
            //                laserBeamContactBalls(with: otherNode)
            //                print("contactLaser")
            //                }
        }
    }
    
    //helper functions
    func laserBeamContactBalls(with other:SKSpriteNode)
    {
        other.removeFromParent()
    }
}
    


//MARK: - functions
extension GameScene {
//    
//    func laserScrolling(){
//        laser.laserHub.position = CGPoint(x: (-self.frame.width / 2) + ((laser.laserHub.frame.width) / 2), y: (self.frame.height / 2) + ((laser.laserHub.frame.height)/2))
//    }
    
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
    

    
}




