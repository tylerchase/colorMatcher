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
    var backgroundNode = SKSpriteNode()
    var backgroundNodeTwo = SKSpriteNode()
    
    var motionManager = CMMotionManager()
    var numberFormatter = NumberFormatter()
    var calibratedAcceleration = CMAcceleration()
    
    override func didMove(to view: SKView) {
        setRandomBackgroundColor()
        moving()
 
    }
    
    func randomNumber() ->CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
    
    var randomRedRounded: CGFloat? = nil
    var randomGreenRounded: CGFloat? = nil
    var randomBlueRounded: CGFloat? = nil
    
    var startColored: UIColor? = nil
    
    
    func setRandomBackgroundColor() {
        let randomRed = randomNumber()
        let randomGreen = randomNumber()
        let randomBlue = randomNumber()
        
        randomRedRounded = (ceil(randomRed * 4) / 4)
        randomGreenRounded = (ceil(randomGreen * 4) / 4)
        randomBlueRounded = (ceil(randomBlue * 4) / 4)
        //        print(randomRed!)
        //        print(randomRedRounded)
        //        print(randomGreen!)
        //        print(randomGreenRounded)
        //        print(randomBlue!)
        //        print(randomBlueRounded!)
        
        //        isColorTheSame()
        
        
        var startColor =  UIColor(red:   randomRedRounded!,
                                  green: randomGreenRounded!,
                                  blue:  randomBlueRounded!,
                                  alpha: 1.0)
        
        
        backgroundNode = childNode(withName: "backgroundNode") as! SKSpriteNode
        backgroundNodeTwo = childNode(withName: "backgroundNodeTwo") as! SKSpriteNode
        let bColor = SKAction.colorize(with: UIColor(red:randomRedRounded!,
                                                    green: randomGreenRounded!,
                                                    blue: randomBlueRounded!,
                                                    alpha: 1),
                                      colorBlendFactor: 0.0, duration: 0.1)
        backgroundNode.run(bColor)
        backgroundNodeTwo.run(bColor)
        
    startColored = startColor
        
    }
    
    
    func moving(){
        
        self.physicsWorld.contactDelegate = self
        
        self.numberFormatter.numberStyle = .decimal
        self.numberFormatter.maximumFractionDigits = 3
        
        changingColorNode = childNode(withName: "changingColorNode") as! SKSpriteNode
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
    
    func methodOfReceivedNotification(notification: Notification){
        print("HI")
        //Take Action on Notification
    }
    
    func setUpDeviceMotionMonitoring() {
        
        if self.motionManager.isDeviceMotionAvailable {
            self.motionManager.deviceMotionUpdateInterval = 0.2
            self.motionManager.startDeviceMotionUpdates(to: OperationQueue.main, withHandler: {
                (data, error) -> Void in
                
//                print("AAYYOO")
                let changingX = CGFloat((data!.gravity.x - self.calibratedAcceleration.x))
                let changingY = CGFloat((data!.gravity.y - self.calibratedAcceleration.y))
                let changingZ = CGFloat((data!.gravity.z - self.calibratedAcceleration.z))
                
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
    
    var changingColor = UIColor()
    
    
    func setBackgroundWithCalibration(r: CGFloat,g: CGFloat ,b: CGFloat) -> UIColor {
//        var colorArray = [String]()
        let redColor = ((r + 1) / 2)
        let greenColor = ((g + 1) / 2)
        let blueColor = ((b + 1) / 2)
        
        let redColorRounder = (ceil(redColor * 4) / 4)
        let greenColorRounder = (ceil(greenColor * 4) / 4)
        let blueColorRounder = (ceil(blueColor * 4) / 4)
        
//        print(redColor)
//        print(redColorRounder)
//        print(greenColor)
//        print(greenColorRounder)
//        print(blueColor)
//        print(blueColorRounder)
//
        let color = SKAction.colorize(with: UIColor(red:redColorRounder,
                                                    green: greenColorRounder,
                                                    blue: blueColorRounder,
                                                    alpha: 1),
                                      colorBlendFactor: 0.0, duration: 0.1)
//        print(color)
//        print("hI")
        changingColorNode.run(color)
        
        
        changingColor =  UIColor(red:   redColorRounder,
                       green: greenColorRounder,
                       blue:  blueColorRounder,
                       alpha: 1.0)
        
//        print(changingColor)
        
        checkIfSame(changingNodeColor: changingColor)
        return changingColor
        
//        let redColorNumber = redColorRounder.description
//        let greenColorNumber = greenColorRounder.description
//        let blueColorNumber = blueColorRounder.description
//        
//        colorArray.insert(redColorNumber, at:0)
//        colorArray.insert(greenColorNumber, at:1)
//        colorArray.insert(blueColorNumber, at:2)
////        print(colorArray)

//        return colorArray
        
//        SKAction.animate(withDuration: self.motionManager.deviceMotionUpdateInterval, animations: { () -> Void in
//            self.view?.backgroundColor = UIColor(red: CGFloat(abs(self.motionManager.deviceMotion!.gravity.x)), green: CGFloat(abs(self.motionManager.deviceMotion!.gravity.y)), blue: CGFloat(abs(self.motionManager.deviceMotion!.gravity.z)), alpha: 1)
        }
    
    func checkIfSame(changingNodeColor: UIColor){
        if changingNodeColor == startColored {
            print (changingNodeColor)
            print(startColored!)
            print("FUCK YEEEAAAHHHHHHHHHHHHH")
            
            setRandomBackgroundColor()
            
        }

        print("test")
//        let startingBackgroundColor = GameViewController().saveBackgroundColor()
//        if changingNodeColor == startingBackgroundColor {
//            print(changingNodeColor)
//            print(startingBackgroundColor)
//            print("Hey MAMA")
//        }
//        print(startingBackgroundColor)
    }
    
    func doSomething(notification: Notification) {
        let newColor:UIColor = notification.userInfo!["bgcolor"] as! UIColor
        print("NEW COLOR")
        print(newColor)
    }
    

    
//    override func update(_ currentTime: TimeInterval) {
//        // Called before each frame is rendered
//    }
        
}
