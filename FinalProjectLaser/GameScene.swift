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
    let hero:Hero = Hero()
    let livesLabel:LivesLabel = LivesLabel()
    let scoreLabel:ScoreLabel = ScoreLabel()
    
    //let laser:Laser = Laser()
}

extension GameScene{
    
    override func didMove(to view: SKView) {
        
//                Background Music
//                setBackgroundMusic(atScene: self, fileName: "Elektronomia - Sky High.mp3")
        
        //physicls world delegate
        self.physicsWorld.contactDelegate = self

        view.showsPhysics = false

        

        // MARK: - HELLO
        
        
        func spawnLeftLasers()
        {
            let laser = Laser()
            self.addChild(laser.laserHub)
        }
        
        func spawnRightLasers()
        {
            let rightLaser = LaserRight()
            self.addChild(rightLaser.laserHubRight)
        }
        
        func randomLaserSelection()
        {
            let selection = Int(arc4random_uniform(2)+1)
            
            if selection == 1 {
                spawnLeftLasers()
            }else{
                spawnRightLasers()
            }
        }


        let waitAction = SKAction.wait(forDuration: 1.5, withRange: 2.0)
        let spawnLaserAction = SKAction.run(randomLaserSelection)
        let spawnEntireAction = SKAction.repeatForever(SKAction.sequence([spawnLaserAction, waitAction]))
        run(spawnEntireAction)
           
//        hero.setUpHero()
        
        self.addChild(hero)
        
        let border = self.childNode(withName: "BorderSprite")
        
        background.createBackgrounds(scene:self)
        
        let borderFrame = SKPhysicsBody(edgeLoopFrom: (border?.frame)!)
        borderFrame.friction = 0
        borderFrame.restitution = 1
        self.physicsBody = borderFrame
        
        self.addChild(livesLabel)

        self.addChild(scoreLabel)
        
    }
    
    func loseLives(){
        
        hero.lives -= 1
        livesLabel.text = "Lives: \(hero.lives)"
    }
    
    func addScore(){
        hero.scores += 10
        scoreLabel.text = "\(hero.scores)"
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
    
    func didBegin(_ contact: SKPhysicsContact) {

        var body1 = SKPhysicsBody()
        var body2 = SKPhysicsBody()
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            body1 = contact.bodyA
            body2 = contact.bodyB
        } else {
            body1 = contact.bodyB
            body2 = contact.bodyA
        }
        
        if body1.categoryBitMask == CategoryEnum.laserHubCategory.rawValue && body2.categoryBitMask == CategoryEnum.smallBallCategory.rawValue {
            
            if let laserLeftHubNode = contact.bodyA.node as? LaserHub{
                
                if laserLeftHubNode.isOn == true{
                    laserLeftHubNode.laserBeam.removeFromParent()
                    addScore()
                    laserLeftHubNode.texture = SKTexture(imageNamed: "LaserHubLeftRed")
                    laserLeftHubNode.isOn = false
                }

            } else if let laserRightHubNode = contact.bodyA.node as? LaserHubRight{
                
                if laserRightHubNode.isOn == true{
                    laserRightHubNode.laserBeamRight.removeFromParent()
                    addScore()
                    laserRightHubNode.texture = SKTexture(imageNamed: "LaserHubRightRed")
                    laserRightHubNode.isOn = false
                }
            }
        }
        

        if body1.categoryBitMask == CategoryEnum.laserBeamCategory.rawValue && body2.categoryBitMask == CategoryEnum.smallBallCategory.rawValue{
            
            guard let node = body2.node as? SKSpriteNode else { return }
            
            projectileExplosion(projectileNode: node)
            body2.node?.removeFromParent()
            
        }

        if body1.categoryBitMask == CategoryEnum.laserBeamCategory.rawValue && body2.categoryBitMask == CategoryEnum.heroCategory.rawValue {
            
            if hero.lives > 0{
                loseLives()
            } else {
//                self.isPaused = true
            }
        }
        

    }
    
    func projectileExplosion(projectileNode:SKSpriteNode){
        
        let explosion = SKEmitterNode(fileNamed: "ProjectileSpark")
        explosion?.zPosition = 3
        explosion?.position = projectileNode.position
        self.addChild(explosion!)
        
        self.run(SKAction.wait(forDuration: 2)){
            explosion?.removeFromParent()
        }
        
    }
}



//MARK: - functions
extension GameScene {
    
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




