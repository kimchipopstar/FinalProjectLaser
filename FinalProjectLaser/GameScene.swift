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
    
    //let laser:Laser = Laser()
}

extension GameScene{
    
    override func didMove(to view: SKView) {
        
        //        Background Music
        //        setBackgroundMusic(atScene: self, fileName: "Elektronomia - Sky High.mp3")
        
        //physicls world delegate
        self.physicsWorld.contactDelegate = self
//        view.showsPhysics = true
        

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
        
        

        let waitAction = SKAction.wait(forDuration: 2)
        let spawnLaserAction = SKAction.run(spawnLasers)
        let spawnRightLaserAction = SKAction.run(spawnRightLasers)
        let entireAction = SKAction.repeatForever(SKAction.sequence([spawnLaserAction, waitAction, spawnRightLaserAction, waitAction]))
        run(entireAction)

        
//        hero.setUpHero()
        
        self.addChild(hero)
        
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
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        let gameScenario = scenario(contact)
        
        switch gameScenario {
        case .hubContactProjectile:
            hubContactsProjectile(contact)
            break
            
        case .projectileContactLaserBeam:
            projectileOrHeroContactLaserBeam(contact)
            break
            
//        case .laserBeamContactHero:
//            laserBeamContactHero(contact)
//            break
            
        default:
            break
        }
    }
    
    
    enum GameSenario {
        case hubContactProjectile
        case projectileContactLaserBeam
        case laserBeamContactHero
        case none
    }
    
    func scenario(_ contact: SKPhysicsContact) -> GameSenario {
        
        let categoryA:UInt32! = contact.bodyA.categoryBitMask
        let categoryB:UInt32! = contact.bodyB.categoryBitMask
        
        if categoryA == CategoryEnum.laserHubCategory.rawValue || categoryB == CategoryEnum.laserHubCategory.rawValue {
            return .hubContactProjectile
        } else if categoryA == CategoryEnum.laserBeamCategory.rawValue || categoryB == CategoryEnum.laserBeamCategory.rawValue{
            return .projectileContactLaserBeam
        }
//        } else if categoryA == CategoryEnum.heroCategory.rawValue || categoryB == CategoryEnum.heroCategory.rawValue{
//            return .laserBeamContactHero
//        }
        else {
            return .none
        }
        
    }
    
    
    func hubContactsProjectile(_ contact: SKPhysicsContact) {
        
        if let laserNode = contact.bodyA.node as? LaserHub {
            laserNode.laserBeam.removeFromParent()
        } else if let laserNode = contact.bodyB.node as? LaserHub {
            laserNode.laserBeam.removeFromParent()
        } else if let laserBeamRightNode = contact.bodyA.node as? LaserHubRight {
            laserBeamRightNode.laserBeamRight.removeFromParent()
        } else if let laserBeamRightNode = contact.bodyB.node as? LaserHubRight {
            laserBeamRightNode.laserBeamRight.removeFromParent()
        }
    }
    
    func projectileOrHeroContactLaserBeam(_ contact: SKPhysicsContact){
        
        if let projectileNode = contact.bodyA.node as? Projectile {
            projectileNode.removeFromParent()
        } else if let projectileNode = contact.bodyB.node as? Projectile {
            projectileNode.removeFromParent()
        } else if (contact.bodyA.node as? Hero) != nil {
            self.isPaused = true
        } else if (contact.bodyB.node as? Hero) != nil{
            self.isPaused = true
        }
        
    }
    
//    func laserBeamContactHero(_ contact: SKPhysicsContact){
//        
//        self.isPaused = true
//        
//    }
    
    // Exclusive Game Scenarios:
    
    // First - Determine which of 1-3 scenarios we should enter.
    // Second - Enter one of scenario 1-3.
    
    // 1 - If hub contacts projectile, then laserBeam goes off
    // 2 - if projectile contacts laser, then projectile disapears
    // 3 - If laserBeam contacts with hero, games pause
    
    
    

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




