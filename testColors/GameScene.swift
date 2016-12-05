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
    
    var scoreLabel : SKLabelNode!
    var score: Int = 0

    var timerLabel : SKLabelNode!
    var timer: Int = 10
    let zero: Int = 0
    
    let manager = CMMotionManager()
    var changingColorNode = SKSpriteNode()
    var backgroundNode = SKSpriteNode()
    var backgroundNodeTwo = SKSpriteNode()
    
    var motionManager = CMMotionManager()
    var numberFormatter = NumberFormatter()
    var calibratedAcceleration = CMAcceleration()
    
    override func didMove(to view: SKView) {
        scoreLabel = SKLabelNode(fontNamed: "Avenir-Medium")
        scoreLabel.text = "Score: \(score)"
        scoreLabel.fontColor = .black
        scoreLabel.fontSize = 60
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.position = CGPoint(x: -105, y:585)
        scoreLabel.zPosition = 1000
        self.addChild(scoreLabel)
        
        timerLabel = SKLabelNode(fontNamed: "Avenir-Medium")
        timerLabel.text = "Timer: \(timer)"
        timerLabel.fontColor = .black
        timerLabel.fontSize = 60
        timerLabel.horizontalAlignmentMode = .right
        timerLabel.position = CGPoint(x: 310, y:585)
        timerLabel.zPosition = 1000
        self.addChild(timerLabel)
        
        
        print(scoreLabel)
        setRandomBackgroundColor()
        moving()
        Timer.scheduledTimer(timeInterval: 1,
                             target: self,
                             selector: #selector(self.updateTime),
                             userInfo: nil,
                             repeats: true)
    }
    
    func updateTime() {
        if timer <= 0 {
            endgame()
        } else {
            timer -= 1
            timerLabel.text = "Timer: \(timer)"
        }
    }
    
    func endgame(){
        saveUserScore(score: score)
        manager.stopDeviceMotionUpdates()
        manager.stopAccelerometerUpdates()
        endgamePopUp()
    }
    
    func endgamePopUp() {
        let gameOver = UIView(frame: CGRect(x:50, y: 200, width: 50, height: 0))
        gameOver.backgroundColor = .red
        self.view?.addSubview(gameOver)
        
        //Call whenever you want to show it and change the size to whatever size you want
        UIView.animate(withDuration: 0.1, animations: {
            gameOver.frame.size = CGSize(width: 275, height: 260)
        })
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
        
        
        let startColor =  UIColor(red:   randomRedRounded!,
                                  green: randomGreenRounded!,
                                  blue:  randomBlueRounded!,
                                  alpha: 1.0)
        
        print(startColor)
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
                if self.timer > self.zero {
                   self.setBackgroundWithCalibration(r: changingX, g: changingY, b: changingZ)
                }
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

            let color = SKAction.colorize(with: UIColor(red:redColorRounder,
                                                        green: greenColorRounder,
                                                        blue: blueColorRounder,
                                                        alpha: 1),
                                          colorBlendFactor: 0.0, duration: 0.1)
            
            changingColorNode.run(color)
            
            
            changingColor =  UIColor(red:   redColorRounder,
                                     green: greenColorRounder,
                                     blue:  blueColorRounder,
                                     alpha: 1.0)
            
            
            checkIfSame(changingNodeColor: changingColor)

        return changingColor
    }
    
    func saveUserScore(score:Int){
        UserDefaults.standard.set(score, forKey: "userScore")
    }

    
    func checkIfSame(changingNodeColor: UIColor){
        if changingNodeColor == startColored {
            print (changingNodeColor)
            print(startColored!)
            print("FUCK YEEEAAAHHHHHHHHHHHHH")
            score += 1
            scoreLabel.text = "Score: \(score)"

            timer += 5
            timerLabel.text = "Timer: \(timer)"
            
//            incrementScore(score: score)
            
            setRandomBackgroundColor()
            
        }

        print("test")

    }
    
    

//    
//    func doSomething(notification: Notification) {
//        let newColor:UIColor = notification.userInfo!["bgcolor"] as! UIColor
//        print("NEW COLOR")
//        print(newColor)
//    }
    

    
//    override func update(_ currentTime: TimeInterval) {
//        // Called before each frame is rendered
//    }
        
}
