//
//  ViewController.swift
//  TheBakingApp
//
//  Created by codedentwickler on 1/24/18.
//  Copyright © 2018 codedentwickler. All rights reserved.
//

import UIKit

class BaseUIViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }

    func instantiateViewController(withIdentifier id : String, from storyBoardName: String) -> UIViewController {
        // Get the Storyboard with id and Create View COntroller with parameter name -> storyBoardName
        let storyboard = UIStoryboard (name: storyBoardName, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: id)
        
        return vc
    }
    
}
