//
//  GameScene.swift
//  testColors
//
//  Created by Tyler Chase on 12/1/16.
//  Copyright © 2016 Tyler Chase. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    let manager = CMMotionManager()
    var changingColorNode = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
        changingColorNode = self.childNode(withName: "changingColorNode") as! SKSpriteNode
        changingColorNode.color = .black
        
        manager.startAccelerometerUpdates()
        manager.accelerometerUpdateInterval = 0.1
        manager.startAccelerometerUpdates(to: OperationQueue.main){
            (data, error) in
            
            self.physicsWorld.gravity = CGVector(dx:CGFloat((data?.acceleration.x)! * 200),dy: CGFloat((data?.acceleration.y)!) * 200)
        }
        
    }
    

    
//    override func update(_ currentTime: TimeInterval) {
//        // Called before each frame is rendered
//    }
        
}
