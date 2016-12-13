    //
//  InstructionsViewController.swift
//  testColors
//
//  Created by Tyler Chase on 12/13/16.
//  Copyright © 2016 Tyler Chase. All rights reserved.
//

import UIKit
import CoreMotion


class InstructionsViewController: UIViewController {
    
    
    @IBOutlet var PlayButton: UIButton!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    
    @IBOutlet var blueLabel: UILabel!
    @IBOutlet var yourColorLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setPlayColor()
        self.numberFormatter.numberStyle = .decimal
        self.numberFormatter.maximumFractionDigits = 3

        if self.motionManager.isDeviceMotionAvailable {
            self.setUpDeviceMotionMonitoring()
        }

        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.motionManager.stopDeviceMotionUpdates()
    }
    
        var motionManager = CMMotionManager()
        var numberFormatter = NumberFormatter()
        var calibratedAcceleration = CMAcceleration()
    
    func setUpDeviceMotionMonitoring() {
        if self.motionManager.isDeviceMotionAvailable {
            self.motionManager.deviceMotionUpdateInterval = 0.1
            self.motionManager.startDeviceMotionUpdates(to: OperationQueue.main, withHandler: {
                (data, error) -> Void in

                let changingXValue = CGFloat((data!.gravity.x - self.calibratedAcceleration.x))
                let changingYValue = CGFloat((data!.gravity.y - self.calibratedAcceleration.y))
                let changingZValue = CGFloat((data!.gravity.z - self.calibratedAcceleration.z))

                self.setTextColorWithAnimation(r: changingXValue, g: changingYValue, b: changingZValue)


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

    func setTextColorWithAnimation(r: CGFloat,g: CGFloat ,b: CGFloat) {

        let redColor = ((r + 1) / 2)
        let greenColor = ((g + 1.5) / 2)
        let blueColor = ((b + 1.85) / 2)
        
        var zeroRed = CGFloat(0.0)
        var zeroGreen = CGFloat(0.0)
        var zeroBlue = CGFloat(0.0)
        

        UIView.transition(with: redLabel, duration: 0.1, options: .transitionCrossDissolve, animations: {
            self.redLabel.textColor = UIColor(red:   redColor,
                                                  green: zeroGreen,
                                                  blue:  zeroBlue,
                                                  alpha: 1.0)
        }, completion: nil)

        UIView.transition(with: greenLabel, duration: 0.1, options: .transitionCrossDissolve, animations: {
            self.greenLabel.textColor = UIColor(red: zeroRed,
                                                  green: greenColor,
                                                  blue:  zeroBlue,
                                                  alpha: 1.0)
        }, completion: nil)
        
        UIView.transition(with: blueLabel, duration: 0.1, options: .transitionCrossDissolve, animations: {
            self.blueLabel.textColor = UIColor(red:   zeroRed,
                                                   green: zeroGreen,
                                                   blue:  blueColor,
                                                   alpha: 1.0)
        }, completion: nil)
        
        UIView.transition(with: yourColorLabel, duration: 0.1, options: .transitionCrossDissolve, animations: {
            self.yourColorLabel.textColor = UIColor(red:   redColor,
                                               green: greenColor,
                                               blue:  blueColor,
                                               alpha: 1.0)
        }, completion: nil)


//        UIView.animate(withDuration: self.motionManager.deviceMotionUpdateInterval, animations: { () -> Void in
//            self.view.backgroundColor = UIColor(red: CGFloat(abs(self.motionManager.deviceMotion!.gravity.x)), green: CGFloat(abs(self.motionManager.deviceMotion!.gravity.y)), blue: CGFloat(abs(self.motionManager.deviceMotion!.gravity.z)), alpha: 1)
//        })
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setPlayColor() {
        PlayButton.backgroundColor = .clear
        PlayButton.layer.cornerRadius = 10
        PlayButton.layer.borderWidth = 2
        PlayButton.layer.borderColor = UIColor.lightGray.cgColor
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
