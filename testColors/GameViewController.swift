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
//                
//                let bgcolor = randomBackgroundColor()
                
//                let sceneColor: [String: UIColor] = ["bgcolor": bgcolor]
//                let notificationIdentifier:String = "SavedBackGroundColor"
                
//                NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: nil)

                
//                NotificationCenter.default.post(name: NSNotification.Name(notificationIdentifier), object: nil, userInfo: sceneColor)
//                print(bgcolor)
//                print(sceneColor)
//                scene.backgroundColor = bgcolor
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
        
         startColored = startColor
        
        return startColor
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
