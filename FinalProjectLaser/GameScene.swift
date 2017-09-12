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
    //let laser:Laser = Laser()
}

extension GameScene{
    
    override func didMove(to view: SKView) {
        
        //        Background Music
        //        setBackgroundMusic(atScene: self, fileName: "Elektronomia - Sky High.mp3")
        
        //physicls world delegate
        self.physicsWorld.contactDelegate = self
        view.showsPhysics = true
        
        func spawnLasers()
        {
            let laser = Laser()
            
            self.addChild(laser.laserHub)
            
        }
        
        
        let waitAction = SKAction.wait(forDuration: 6)
        let spawnLaserAction = SKAction.run(spawnLasers) //call your function
        let entireACtion = SKAction.repeatForever(SKAction.sequence([spawnLaserAction, waitAction]))
        run(entireACtion)
        
        hero.setUpHero()
        
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
        removeExessProjectiles()
        Laser.removeExessLasers(scene: self)
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
            
            // call hubContactsProjectile function
            
            break
        case .projectileContactLaserBeam:
            projectileContactLaserBeam(contact)
            // call projectile contacts laser function
            break
        case .laserBeamContactHero:
            laserBeamContactHero(contact)
            // call laserbeam hits hero function.
            break
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
        } else if categoryA == CategoryEnum.heroCategory.rawValue || categoryB == CategoryEnum.heroCategory.rawValue{
            return .laserBeamContactHero
        } else {
            return .none
        }
        
    }
    
    func hubContactsProjectile(_ contact: SKPhysicsContact) {
        
        if let laserNode = contact.bodyA.node as? LaserHub {
            laserNode.laserBeam.removeFromParent()
        } else if let laserNode = contact.bodyB.node as? LaserHub {
            laserNode.laserBeam.removeFromParent()
        }
    }
    
    func projectileContactLaserBeam(_ contact: SKPhysicsContact){
        
        if let projectileNode = contact.bodyA.node as? SKSpriteNode {
            projectileNode.removeFromParent()
        } else if let projectileNode = contact.bodyB.node as? SKSpriteNode {
            projectileNode.removeFromParent()
        }
        
    }
    
    func laserBeamContactHero(_ contact: SKPhysicsContact){
    
    }
    
    // Exclusive Game Scenarios:
    
    // First - Determine which of 1-3 scenarios we should enter.
    // Second - Enter one of scenario 1-3.
    
    // 1 - If hub contacts projectile, then laserBeam goes off
    // 2 - if projectile contacts laser, then projectile disapears
    // 3 - If laserBeam contacts with hero, games pause
    
    func contactLogic(contact:SKPhysicsContact) {
        
        
        
        let categoryA:UInt32! = contact.bodyA.categoryBitMask
        let categoryB:UInt32! = contact.bodyB.categoryBitMask
        
        if categoryA == CategoryEnum.laserHubCategory.rawValue || categoryB == CategoryEnum.laserHubCategory.rawValue {
            if let laserNode = contact.bodyA.node as? LaserHub {
                laserNode.laserBeam.removeFromParent()
            }
            
            print("contactHub")
        } else if categoryA == CategoryEnum.laserBeamCategory.rawValue || categoryB == CategoryEnum.laserBeamCategory.rawValue {
            
            let otherNode:SKSpriteNode
            if categoryA == CategoryEnum.laserBeamCategory.rawValue {
                
                otherNode = contact.bodyB.node as! SKSpriteNode
                if otherNode.physicsBody?.categoryBitMask == CategoryEnum.smallBallCategory.rawValue {
                    laserBeamContactBalls(with: otherNode)
                } else if otherNode.physicsBody?.categoryBitMask == CategoryEnum.heroCategory.rawValue{
                    view?.isPaused = true
                }
            } else {
                otherNode = contact.bodyA.node as! SKSpriteNode
                if otherNode.physicsBody?.categoryBitMask == CategoryEnum.smallBallCategory.rawValue {
                    laserBeamContactBalls(with: otherNode)
                } else if otherNode.physicsBody?.categoryBitMask == CategoryEnum.heroCategory.rawValue{
                    view?.isPaused = true
                }
            }
        }
    }
    
    func contact(_ mask: UInt32, _ contact: SKPhysicsContact) {
        
        if let category = CategoryEnum.init(rawValue: mask) {
            
            switch category {
                
            case .laserBeamCategory:
                
                let otherNode:SKSpriteNode

                let categoryA = CategoryEnum.init(rawValue: contact.bodyA.categoryBitMask)
                if categoryA == .laserBeamCategory {
                    otherNode = contact.bodyB.node as! SKSpriteNode
                    if otherNode.physicsBody?.categoryBitMask == CategoryEnum.smallBallCategory.rawValue {
                        laserBeamContactBalls(with: otherNode)
                    } else if otherNode.physicsBody?.categoryBitMask == CategoryEnum.heroCategory.rawValue{
                        view?.isPaused = true
                    }
                } else {
                    otherNode = contact.bodyA.node as! SKSpriteNode
                    if otherNode.physicsBody?.categoryBitMask == CategoryEnum.smallBallCategory.rawValue {
                        laserBeamContactBalls(with: otherNode)
                    } else if otherNode.physicsBody?.categoryBitMask == CategoryEnum.heroCategory.rawValue{
                        view?.isPaused = true
                    }
                }
                
                break
                
            case .laserHubCategory:
                
                if let laserNode = contact.bodyA.node as? LaserHub {
                    laserNode.laserBeam.removeFromParent()
                }
                print("contactHub")
                
                break
                
            default:
                break
            }
        }
        
    }
    
    //helper functions
    func laserBeamContactBalls(with other:SKSpriteNode) {
        other.removeFromParent()
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




