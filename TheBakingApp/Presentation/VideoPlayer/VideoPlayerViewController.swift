//
//  VideoPlayerViewController.swift
//  TheBakingApp
//
//  Created by codedentwickler on 2/13/18.
//  Copyright © 2018 codedentwickler. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class VideoPlayerViewController: UIViewController {
    
    var menuIndex: Int = 0
    var step: Step!
    
    @IBOutlet weak var stepDescriptionLabel: UILabel!
    @IBOutlet weak var playerRootView: UIView!
    @IBOutlet weak var stepDescRootView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerRootView.superview?.clipsToBounds = true
        playerRootView.superview?.layer.masksToBounds = true
        playerRootView.dropShadow()
        
        if step.videoURL.count != 0 {
            let player = AVPlayer(url: URL(string: step.videoURL)!)
            let playerController = AVPlayerViewController()
            
            playerController.player = player
            self.addChildViewController(playerController)
            
            self.playerRootView.addSubview(playerController.view)
            playerController.view.frame = self.playerRootView.frame
            
            player.play()
        } else {
            
            //playerRootView.is,Hidden = true
            playerRootView.removeFromSuperview()
            self.view.reloadInputViews()
        }
        
        let stepDescription = "\(menuIndex + 1). \(step.shortDescription)"
        stepDescriptionLabel.text = stepDescription
    }
    
}
