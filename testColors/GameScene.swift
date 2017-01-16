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
import AVFoundation
import AudioToolbox

class GameScene: SKScene, SKPhysicsContactDelegate {
    var viewController: GameViewController!
    var audioPlayer = AVAudioPlayer()
    
    private var label : SKLabelNode?
    
    var scoreLabel : SKLabelNode!
    var score: Int = 0

    var timerLabel : SKLabelNode!
    var timer: Int = 15
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
        
        
//        print(scoreLabel)
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
    
    var gameOver : UIView!
    var gameOverScoreLabel : UILabel!
    var btn: UIButton!
    var goHomebtn: UIButton!
    

    func endgamePopUp() {
        gameOver.backgroundColor = .gray
        gameOver.layer.cornerRadius = 10.0
        gameOver.isHidden = false
//        self.view?.addSubview(gameOver)
        
        // Call whenever you want to show it and change the size to whatever size you want
        if self.gameOver.isHidden == true || self.btn.isHidden == true {
            self.gameOver.isHidden = false
            self.btn.isHidden = false
        }
        
        
        btn.backgroundColor = .clear
        btn.layer.cornerRadius = 10
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.white.cgColor
        btn.titleLabel?.textColor = UIColor.black
        btn.layer.backgroundColor = UIColor.green.cgColor
        
        goHomebtn.backgroundColor = .clear
        goHomebtn.layer.cornerRadius = 10
        goHomebtn.layer.borderWidth = 1
        goHomebtn.layer.borderColor = UIColor.white.cgColor
        goHomebtn.layer.backgroundColor = UIColor.black.cgColor
        
//        goHomebtn.layer.shadowColor = UIColor.black.cgColor
//        goHomebtn.layer.shadowRadius = 5.0
//        
//        
//        btn.layer.shadowColor = UIColor.black.cgColor
//        btn.layer.shadowRadius = 5.0
//        goHomebtn.layer.

//        goHomebtn.backgroundColor = UIColor.black
//        goHomebtn.setTitle("Go Home", for: .normal)
//        goHomebtn.titleLabel?.font = UIFont(name: "Avenir Medium", size: 22)!
        goHomebtn.addTarget(self, action: #selector(goHome), for: .touchUpInside)
//        goHomebtn.tag = 1
        goHomebtn.layer.cornerRadius = 10.0
//        gameOver.addSubview(goHomebtn)
//        btn.backgroundColor = UIColor.green
//        btn.setTitle("Play Again", for: .normal)
        
//        btn.titleLabel?.font = UIFont(name: "Avenir Medium", size: 22)!
//        btn.titleLabel?.textColor = UIColor.black
        btn.addTarget(self, action: #selector(popUpPlayAgain), for: .touchUpInside)
        btn.tag = 1
        gameOverScoreLabel.text = "\(score)"

    }
        
    let onSelectedSkin = Notification.Name("on-sekected-skin")
    
    func goHome (sender: UIButton!){
        NotificationCenter.default.post(name: onSelectedSkin, object: nil)
    }
    
    func popUpPlayAgain(sender:UIButton!){
//        print("playing again")
        self.gameOver.isHidden = true
        self.btn.alpha = 1
        self.btn.isHidden = true
        self.score = 0
        scoreLabel.text = "Score: \(score)"
        
        setRandomBackgroundColor()
        resetTimer()
        moving()
    }
    
    func resetTimer(){
        timer = 15 + 1
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
        
        randomRedRounded = (ceil(randomRed * 3) / 3)
        randomGreenRounded = (ceil(randomGreen * 3) / 3)
        randomBlueRounded = (ceil(randomBlue * 3) / 3)

        
        
        let startColor =  UIColor(red:   randomRedRounded!,
                                  green: randomGreenRounded!,
                                  blue:  randomBlueRounded!,
                                  alpha: 1.0)
//        print(randomRedRounded!)
//        print(randomGreenRounded!)
//        print(randomBlueRounded!)
        
        if randomRedRounded! == 1 && randomGreenRounded! == 1 && randomBlueRounded! == 1 {
            setRandomBackgroundColor()
        }
//        print(startColor)
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
        manager.accelerometerUpdateInterval = 0.1
        manager.startAccelerometerUpdates(to: OperationQueue.main){
            (data, error) in
            
            self.physicsWorld.gravity = CGVector(dx:CGFloat((data?.acceleration.x)! ),dy: CGFloat((data?.acceleration.y)!) )
        }
        if self.motionManager.isDeviceMotionAvailable {
            self.setUpDeviceMotionMonitoring()
        }
    }
    
    func methodOfReceivedNotification(notification: Notification){
//        print("HI")
        //Take Action on Notification
    }
    
    func setUpDeviceMotionMonitoring() {
        
        if self.motionManager.isDeviceMotionAvailable {
            self.motionManager.deviceMotionUpdateInterval = 0.1
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
        
        let redColorRounder = (ceil(redColor * 3) / 3)
        let greenColorRounder = (ceil(greenColor * 3) / 3)
        let blueColorRounder = (ceil(blueColor * 3) / 3)

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
        
        if let highscore: Int = UserDefaults.standard.integer(forKey: "userScore"){
            if highscore < score {
                UserDefaults.standard.set(score, forKey: "userScore")
            }
        }
        
    }

    
    func checkIfSame(changingNodeColor: UIColor){
        if changingNodeColor == startColored {
//            print (changingNodeColor)
//            print(startColored!)
            
            score += 1
            scoreLabel.text = "Score: \(score)"

            timer += 5
            timerLabel.text = "Timer: \(timer)"
            playAudio()
//            incrementScore(score: score)
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            
            setRandomBackgroundColor()
            
        }
    }
    
    func playAudio() {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "button-27", ofType:"mp3")!))
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        }
        catch {
            print(error)
        }
    }


        
}
