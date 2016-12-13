//
//  LandingViewController.swift
//  testColors
//
//  Created by Tyler Chase on 12/3/16.
//  Copyright © 2016 Tyler Chase. All rights reserved.
//

import UIKit
import CoreMotion

class LandingViewController: UIViewController {

    
    @IBOutlet var highscoreLabel: UILabel!
    
    @IBOutlet var appNameLabel: UILabel!
    @IBOutlet var appNameLabel2: UILabel!
    
    @IBOutlet var Play: UIButton!
    @IBOutlet var Instructions: UIButton!
    
//    @IBOutlet var testLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let newscore = highScore()
        self.highscoreLabel.text = "Highscore: \(newscore)"
        print(newscore)
        
        setPlayColor()
        setInstructionsColor()
        
        callIncrement()
//        incrementRGBSin(time: t!)
        
//        self.numberFormatter.numberStyle = .decimal
//        self.numberFormatter.maximumFractionDigits = 3
//        
//        if self.motionManager.isDeviceMotionAvailable {
//            self.setUpDeviceMotionMonitoring()
//        }
        
        // Do any additional setup after loading the view.
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        self.motionManager.stopDeviceMotionUpdates()
//    }
    
    /* ------- Importing Accelerometer data  ---------- */
// 
//    var motionManager = CMMotionManager()
//    var numberFormatter = NumberFormatter()
//    var calibratedAcceleration = CMAcceleration()
//    
//    func setUpDeviceMotionMonitoring() {
//        if self.motionManager.isDeviceMotionAvailable {
//            self.motionManager.deviceMotionUpdateInterval = 0.1
//            self.motionManager.startDeviceMotionUpdates(to: OperationQueue.main, withHandler: {
//                (data, error) -> Void in
//                
//                let changingXValue = CGFloat((data!.gravity.x - self.calibratedAcceleration.x))
//                let changingYValue = CGFloat((data!.gravity.y - self.calibratedAcceleration.y))
//                let changingZValue = CGFloat((data!.gravity.z - self.calibratedAcceleration.z))
//                
//                self.setTextColorWithAnimation(r: changingXValue, g: changingYValue, b: changingZValue)
//                
//                
////                self.xValueLabel.text = self.numberFormatter.stringFromNumber(data!.gravity.x - self.calibratedAcceleration.x)
////                self.yValueLabel.text = self.numberFormatter.stringFromNumber(data!.gravity.y - self.calibratedAcceleration.y)
////                self.zValueLabel.text = self.numberFormatter.stringFromNumber(data!.gravity.z - self.calibratedAcceleration.z)
////                
////                if self.functionalitySwitch.on == true {
////                    self.setBackgroundWithCalibration()
////                } else if self.view.backgroundColor != UIColor.whiteColor() {
////                    self.view.backgroundColor = UIColor.whiteColor()
//                
////                }
//            })
//        }
//    }
//    
//    func setTextColorWithAnimation(r: CGFloat,g: CGFloat ,b: CGFloat) {
//        
//        let redColor = ((r + 1) / 2)
//        let greenColor = ((g + 1) / 2)
//        let blueColor = ((b + 1) / 2)
//        
//        UIView.transition(with: appNameLabel, duration: 0.1, options: .transitionCrossDissolve, animations: {
//            self.appNameLabel.textColor = UIColor(red:   redColor,
//                                                  green: greenColor,
//                                                  blue:  blueColor,
//                                                  alpha: 1.0)
//        }, completion: nil)
//        
//        UIView.transition(with: appNameLabel2, duration: 0.1, options: .transitionCrossDissolve, animations: {
//            self.appNameLabel2.textColor = UIColor(red:   redColor,
//                                                  green: greenColor,
//                                                  blue:  blueColor,
//                                                  alpha: 1.0)
//        }, completion: nil)
//        
//        
////        UIView.animate(withDuration: self.motionManager.deviceMotionUpdateInterval, animations: { () -> Void in
////            self.view.backgroundColor = UIColor(red: CGFloat(abs(self.motionManager.deviceMotion!.gravity.x)), green: CGFloat(abs(self.motionManager.deviceMotion!.gravity.y)), blue: CGFloat(abs(self.motionManager.deviceMotion!.gravity.z)), alpha: 1)
////        })
//    }
    
    func setPlayColor() {
        Play.backgroundColor = .clear
        Play.layer.cornerRadius = 10
        Play.layer.borderWidth = 2
        Play.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func setInstructionsColor() {
        Instructions.backgroundColor = .clear
        Instructions.layer.cornerRadius = 10
        Instructions.layer.borderWidth = 2
        Instructions.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    var t: CGFloat? = 0.0
    
    func callIncrement() {
        incrementRGBSin(time: t!)
    }

    func incrementRGBSin(time: CGFloat) {
        
        let redSin = (sin(t! + 0.1) * 1/2) + 1/2
//        let greenSin = (sin(t! + 0.4) * 1/2) + 1/2
        let greenSin = CGFloat(0.67)
        let blueSin = (sin(t! + 0.6) * 1/2) + 1/2
        
//        print(redSin)
//        print(greenSin)
//        print(blueSin)
        
        changeTestLabelColor(r: redSin, g: greenSin, b: blueSin)
    }
    
   func changeTestLabelColor(r: CGFloat, g: CGFloat , b: CGFloat) {
    
    UIView.transition(with: appNameLabel2, duration: 0.07, options: .transitionCrossDissolve, animations: {
        self.appNameLabel2.textColor = UIColor(red:   r,
                                               green: g,
                                               blue:  b,
                                               alpha: 1.0)
    }, completion: nil )
    
    UIView.transition(with: appNameLabel, duration: 0.07, options: .transitionCrossDissolve, animations: {
        self.appNameLabel.textColor = UIColor(red:   r,
                                              green: g,
                                              blue:  b,
                                              alpha: 1.0)
    }, completion: {_ in
        self.t = self.t! + 0.1
        self.incrementRGBSin(time: self.t!)
    })
    

    
    }
    

    
    func highScore() -> Int {
        return UserDefaults.standard.integer(forKey: "userScore")
    }
    
    func resetHighScore () {        UserDefaults.standard.removeObject(forKey: "userScore")
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
