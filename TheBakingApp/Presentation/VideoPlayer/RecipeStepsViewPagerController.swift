//
//  RecipeStepsViewPagerController.swift
//  TheBakingApp
//
//  Created by codedentwickler on 2/13/18.
//  Copyright © 2018 codedentwickler. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import SHViewPager
import Foundation

class RecipeStepsViewPagerController: UIViewController {
    
    public var currentRecipe: Recipe!
    public var selectedStepIndex: Int!
    
    fileprivate var menuItems = [String]()
    
    @IBOutlet weak var pager: SHViewPager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuItems = currentRecipe.steps.map({ "Step \($0.id)" })
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.47, green:0.33, blue:0.28, alpha:1.0)
        
        pager.dataSource = self
        pager.delegate = self
        pager.reloadData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        pager.pagerWillLayoutSubviews()
    }
}

// Mark - SHViewDataSource
extension RecipeStepsViewPagerController : SHViewPagerDataSource {
    
    func numberOfPages(in viewPager: SHViewPager) -> Int {
        return currentRecipe.steps.count
    }
    
    func containerController(for viewPager: SHViewPager) -> UIViewController {
        return self
    }
    
    func viewPager(_ viewPager: SHViewPager, controllerForPageAt index: Int) -> UIViewController {
        
        let videoPlayerVc = self.storyboard?.instantiateViewController(withIdentifier: "VideoPlayerViewController")
            as! VideoPlayerViewController

        let step = currentRecipe.steps[index]
        
        videoPlayerVc.menuIndex = index
        videoPlayerVc.step = step
        
        return videoPlayerVc
    }
    
    func viewPager(_ viewPager: SHViewPager, titleForPageMenuAt index: Int) -> String {
        return menuItems[index]
    }
}

extension RecipeStepsViewPagerController: SHViewPagerDelegate {
    
    func menuWidthType(in viewPager: SHViewPager) -> SHViewPagerMenuWidthType {
        return .wide
    }
    
    func backgroundColorForMenu(in viewPager: SHViewPager) -> UIColor {
        return UIColor(red:0.47, green:0.33, blue:0.28, alpha:1.0)
    }
    
    func textColorForMenu(in viewPager: SHViewPager) -> UIColor {
        return UIColor.white
    }
    
    func fontForMenu(in viewPager: SHViewPager) -> UIFont {
        return UIFont.boldSystemFont(ofSize: 16.0)
    }
    
}
