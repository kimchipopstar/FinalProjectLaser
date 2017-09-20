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
    var spawnInterval:Double = 3

}

extension GameScene{
    
    override func didMove(to view: SKView) {
        
        //Background Music
//                setBackgroundMusic(atScene: self, fileName: "Elektronomia - Sky High.mp3")
        
        //physicls world delegate
        self.physicsWorld.contactDelegate = self
        view.showsPhysics = false

        func decreaseLaserSpawnTime () {
            removeAction(forKey: "spawnLoop")
            self.spawnInterval = self.spawnInterval * 0.8
            let waitAction = SKAction.wait(forDuration: (self.spawnInterval), withRange: (self.spawnInterval) * 1.5)
            let spawnLaserAction = SKAction.run(randomLaserSelection)
            let spawnEntireAction = SKAction.repeatForever(SKAction.sequence([ waitAction, spawnLaserAction]))
            run(spawnEntireAction, withKey: "spawnLoop")
        }

        // MARK: - HELLO
        
        let wait = SKAction.wait(forDuration:20.0)
        let decreaseTimeInterval = SKAction.run(decreaseLaserSpawnTime)
        let speedUpBackgroundAction = SKAction.run(background.backgroundSpeedIncrease)
        let speedUpLeftLaserAction = SKAction.run(Laser.leftLaserSpeedIncrease)
        let speedUpRightLaserAction = SKAction.run(LaserRight.rightLaserSpeedIncrease)
        let increaseBackgroundSpeedAction = SKAction.repeatForever(SKAction.sequence([wait, speedUpBackgroundAction, speedUpLeftLaserAction, speedUpRightLaserAction, decreaseTimeInterval]))
        run(increaseBackgroundSpeedAction)
        
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


        removeAction(forKey: "spawnLoop")
        self.spawnInterval = self.spawnInterval * 0.95
        
        let waitAction = SKAction.wait(forDuration: (self.spawnInterval), withRange: (self.spawnInterval) * 1.2)
        let spawnLaserAction = SKAction.run(randomLaserSelection)
        let spawnEntireAction = SKAction.repeatForever(SKAction.sequence([ waitAction, spawnLaserAction]))
        run(spawnEntireAction, withKey: "spawnLoop")
        
        
        
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
        
        if hero.lives == 2 {
            hero.texture = SKTexture(imageNamed: "Laser1")
        }else if hero.lives == 1{
            hero.texture = SKTexture(imageNamed: "Laser2")
            if let heroDamageSmoke = SKEmitterNode(fileNamed: "HeroSmoke") {
                heroDamageSmoke.particleSize = CGSize(width: 0, height: 0)
                heroDamageSmoke.position = CGPoint(x: 0, y: 80)
                heroDamageSmoke.zPosition = 1
                heroDamageSmoke.isHidden = false
                hero.addChild(heroDamageSmoke)
            }
        }else{
            hero.texture = SKTexture(imageNamed: "Laser3")
            if let heroDamageFire = SKEmitterNode(fileNamed: "HeroFire") {
                heroDamageFire.particleSize = CGSize(width: 0, height: 0)
                heroDamageFire.position = CGPoint(x: 0, y: 80)
                heroDamageFire.zPosition = 2
                heroDamageFire.isHidden = false
                hero.addChild(heroDamageFire)
            }
        }
    }
    
    func addScore(){
        hero.scores += 10
        scoreLabel.text = "\(hero.scores)"
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        background.moveBackgrounds(scene:self, hero:hero)
        Laser.moveLaser(scene:self, hero:hero)
        LaserRight.moveLaser(scene:self, hero:hero)

        removeExessProjectiles()
        Laser.removeExessLasers(scene: self)
        LaserRight.removeExessLasers(scene: self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in (touches ) {
            let location = touch.location(in: self)
            
            
            let projectile = hero.createProjectile()
            
            self.addChild(projectile)
            
            hero.launchTowards(location: location, spriteNode:projectile)
        }
        
//        heroFireProjectile()
    }
    
//    func heroFireProjectile(){
//        let fire = SKEmitterNode(fileNamed: "HeroShootingFire")
//        fire?.zPosition = 5
//        fire?.position = hero.position
//        self.addChild(fire!)
//        
//        self.run(SKAction.wait(forDuration: 0.35)){
//            fire?.removeFromParent()
//        }
//    }
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
        
        if body1.categoryBitMask == CategoryEnum.laserHubCategory.rawValue && body2.categoryBitMask == CategoryEnum.projectileCategory.rawValue {
            
            if let laserLeftHubNode = contact.bodyA.node as? LaserHub{
                
                if laserLeftHubNode.isOn == true{
                    laserLeftHubNode.laserBeam.removeFromParent()
                    addScore()
                    laserLeftHubNode.texture = SKTexture(imageNamed: "LaserHubLeftRed")
                    laserLeftHubNode.isOn = false
//                    let buttonSound = SKAction.playSoundFileNamed("ButtonPress", waitForCompletion: false)
//                    let laserPowerDownSound = SKAction.playSoundFileNamed("laserPowerDown", waitForCompletion: false)
//                    run(buttonSound)
//                    run(laserPowerDownSound)
                }

            } else if let laserRightHubNode = contact.bodyA.node as? LaserHubRight{
                
                if laserRightHubNode.isOn == true{
                    laserRightHubNode.laserBeamRight.removeFromParent()
                    addScore()
                    laserRightHubNode.texture = SKTexture(imageNamed: "LaserHubRightRed")
                    laserRightHubNode.isOn = false
                    let buttonSound = SKAction.playSoundFileNamed("ButtonPress", waitForCompletion: false)
                    let laserPowerDownSound = SKAction.playSoundFileNamed("laserPowerDown", waitForCompletion: false)
                    run(buttonSound)
                    run(laserPowerDownSound)
                }
            }
        }
        

        if body1.categoryBitMask == CategoryEnum.laserBeamCategory.rawValue && body2.categoryBitMask == CategoryEnum.projectileCategory.rawValue{
            
            guard let node = body2.node as? SKSpriteNode else { return }
            
            projectileExplosion(projectileNode: node)
            body2.node?.removeFromParent()
            
        }

        if body1.categoryBitMask == CategoryEnum.laserBeamCategory.rawValue && body2.categoryBitMask == CategoryEnum.heroCategory.rawValue {
            
            if hero.lives > 0{
                loseLives()
            } else {
                self.isPaused = true
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
            if temp.name == "projectile" && temp.position.y < -600 {
                temp.removeFromParent()
                print(temp.position.y)
            }
        }
    }
}




