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
//        print(newscore)
        
        setPlayColor()
        setInstructionsColor()
        
        callIncrement()

        // Do any additional setup after loading the view.
    }
    
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
