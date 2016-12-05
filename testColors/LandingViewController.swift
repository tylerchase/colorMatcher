//
//  LandingViewController.swift
//  testColors
//
//  Created by Tyler Chase on 12/3/16.
//  Copyright © 2016 Tyler Chase. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {

    
    @IBOutlet var highscoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let newscore = highScore()
        self.highscoreLabel.text = "High score: \(newscore)"
        print(newscore)
        // Do any additional setup after loading the view.
    }
    
    func highScore() -> Int {
        return UserDefaults.standard.integer(forKey: "userScore")
    }
    
    func resetHighScore () {
        UserDefaults.standard.removeObject(forKey: "userScore")
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
