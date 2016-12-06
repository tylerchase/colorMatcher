//
//  GameViewController.swift
//  testColors
//
//  Created by Tyler Chase on 12/1/16.
//  Copyright © 2016 Tyler Chase. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
   
        override func viewDidLoad() {
        super.viewDidLoad()
        let onSelectedSkin = Notification.Name("on-sekected-skin")
        NotificationCenter.default.addObserver(self, selector: #selector(goHomeView), name: onSelectedSkin, object: nil)
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
            
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
//            view.showsFPS = true
//            view.showsNodeCount = true
        }
    }
    
       
    
    func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
    
    var randomRedRounded: CGFloat? = nil
    var randomGreenRounded: CGFloat? = nil
    var randomBlueRounded: CGFloat? = nil
    
    var startColored: UIColor? = nil
    
    func randomBackgroundColor() -> UIColor {
        let randomRed = random()
        let randomGreen = random()
        let randomBlue = random()
        
        randomRedRounded = (ceil(randomRed * 4) / 4)
        randomGreenRounded = (ceil(randomGreen * 4) / 4)
        randomBlueRounded = (ceil(randomBlue * 4) / 4)
        
         let startColor =  UIColor(red:   randomRedRounded!,
                       green: randomGreenRounded!,
                       blue:  randomBlueRounded!,
                       alpha: 1.0)
        
         startColored = startColor
        
        return startColor
    }
    
    func goHomeView() {
        self.performSegue(withIdentifier: "goHome", sender: self)
    }


    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
