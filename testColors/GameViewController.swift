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
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                scene.backgroundColor = randomBackgroundColor()
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
    var randomRed: CGFloat? = nil
    var randomGreen: CGFloat? = nil
    var randomBlue: CGFloat? = nil
    
    func randomBackgroundColor() -> UIColor {
        randomRed = random()
        randomGreen = random()
        randomBlue = random()
        
        let randomRedRounded = (ceil(randomRed! * 8) / 8)
        let randomGreenRounded = (ceil(randomGreen! * 8) / 8)
        let randomBlueRounded = (ceil(randomBlue! * 8) / 8)
//        print(randomRed!)
//        print(randomRedRounded)
//        print(randomGreen!)
//        print(randomGreenRounded)
//        print(randomBlue!)
        print(randomBlueRounded)
        print(blueColorRounder)
        
        
        return UIColor(red:   randomRedRounded,
                       green: randomGreenRounded,
                       blue:  randomBlueRounded,
                       alpha: 1.0)
        
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
