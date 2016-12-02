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
    
    var motionManager = CMMotionManager()
    var numberFormatter = NumberFormatter()
    var calibratedAcceleration = CMAcceleration()
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
        self.numberFormatter.numberStyle = .decimal
        self.numberFormatter.maximumFractionDigits = 3
        
        changingColorNode = self.childNode(withName: "changingColorNode") as! SKSpriteNode
//        changingColorNode.color = .black
        
        manager.startAccelerometerUpdates()
        manager.accelerometerUpdateInterval = 0.3
        manager.startAccelerometerUpdates(to: OperationQueue.main){
            (data, error) in
            
            self.physicsWorld.gravity = CGVector(dx:CGFloat((data?.acceleration.x)! ),dy: CGFloat((data?.acceleration.y)!) )
        }
        if self.motionManager.isDeviceMotionAvailable {
            self.setUpDeviceMotionMonitoring()
        }
        
    }
    
    func setUpDeviceMotionMonitoring() {
        
        if self.motionManager.isDeviceMotionAvailable {
            self.motionManager.deviceMotionUpdateInterval = 0.2
            self.motionManager.startDeviceMotionUpdates(to: OperationQueue.main, withHandler: {
                (data, error) -> Void in
                
//                print("AAYYOO")
                var changingX = CGFloat((data!.gravity.x - self.calibratedAcceleration.x))
                var changingY = CGFloat((data!.gravity.y - self.calibratedAcceleration.y))
                var changingZ = CGFloat((data!.gravity.z - self.calibratedAcceleration.z))
                
//                var changingRed = self.numberFormatter.string(from: NSNumber(value: changingX))
//                var changingGreen = self.numberFormatter.string(from: NSNumber(value: changingY))
//                var changingBlue = self.numberFormatter.string(from: NSNumber(value: changingZ))
                
                self.setBackgroundWithCalibration(r: changingX, g: changingY, b: changingZ)
                
//                self.xValueLabel.text = self.numberFormatter.stringFromNumber(data!.gravity.x - self.calibratedAcceleration.x)
//                self.yValueLabel.text = self.numberFormatter.stringFromNumber(data!.gravity.y - self.calibratedAcceleration.y)
//                self.zValueLabel.text = self.numberFormatter.stringFromNumber(data!.gravity.z - self.calibratedAcceleration.z)
//                
//                if self.functionalitySwitch.on == true {
//                    self.setBackgroundWithCalibration()
//                } else if self.view.backgroundColor != UIColor.whiteColor() {
//                    self.view.backgroundColor = UIColor.whiteColor()
//                }
            })
        }
    }
    
    
    
    func setBackgroundWithCalibration(r: CGFloat,g: CGFloat ,b: CGFloat) {
        let redColor = ((r + 1) / 2)
        let greenColor = ((g + 1) / 2)
        let blueColor = ((b + 1) / 2)
        
        let redColorRounder = (ceil(redColor * 8) / 8)
        let greenColorRounder = (ceil(greenColor * 8) / 8)
        let blueColorRounder = (ceil(blueColor * 8) / 8)
        
        print(redColor)
        print(redColorRounder)
        print(greenColor)
        print(greenColorRounder)
        print(blueColor)
        print(blueColorRounder)
//
        let color = SKAction.colorize(with: UIColor(red: redColorRounder,
                                                    green: greenColorRounder,
                                                    blue: blueColorRounder,
                                                    alpha: 1),
                                      colorBlendFactor: 0.0, duration: 0.1)
//        print(color)
//        print("hI")
        
        changingColorNode.run(color)
        
//        SKAction.animate(withDuration: self.motionManager.deviceMotionUpdateInterval, animations: { () -> Void in
//            self.view?.backgroundColor = UIColor(red: CGFloat(abs(self.motionManager.deviceMotion!.gravity.x)), green: CGFloat(abs(self.motionManager.deviceMotion!.gravity.y)), blue: CGFloat(abs(self.motionManager.deviceMotion!.gravity.z)), alpha: 1)
        }
    

    
//    override func update(_ currentTime: TimeInterval) {
//        // Called before each frame is rendered
//    }
        
}
