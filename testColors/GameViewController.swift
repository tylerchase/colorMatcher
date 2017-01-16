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
    
    @IBOutlet weak var playAgainButton: UIButton!
   
    @IBOutlet weak var goHomeButton: UIButton!
    @IBOutlet weak var gameOverScoreLabel: UILabel!
    @IBOutlet weak var menuAlertView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let onSelectedSkin = Notification.Name("on-sekected-skin")
        NotificationCenter.default.addObserver(self, selector: #selector(goHomeView), name: onSelectedSkin, object: nil)
        
        
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") as? GameScene {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
            
                
                // Set the popup properties
                scene.gameOver = menuAlertView
                scene.gameOverScoreLabel = gameOverScoreLabel
                scene.btn = playAgainButton
                scene.goHomebtn = goHomeButton
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
        }
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
