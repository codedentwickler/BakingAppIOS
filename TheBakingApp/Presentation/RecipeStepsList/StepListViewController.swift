//
//  StepListViewController.swift
//  TheBakingApp
//
//  Created by codedentwickler on 2/13/18.
//  Copyright © 2018 codedentwickler. All rights reserved.
//

import UIKit

class StepListViewController: BaseUIViewController, RecipeStepsView {
    
    public var currentRecipe: Recipe!
    
    private var presenter: StepListPresenter!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var ingredientsLabelContainerView: UIView!
    @IBOutlet weak var ingredientListLabel: UILabel!
    @IBOutlet weak var ingredientsLabelHeight: NSLayoutConstraint!
    @IBOutlet weak var ingredientsLabelContainerHeight: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNormalTitle(currentRecipe.name)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let ingredientHeight = 24 * currentRecipe.ingredients.count
        
        ingredientsLabelHeight.constant = CGFloat(ingredientHeight)
        ingredientsLabelHeight.isActive = true
        
        ingredientsLabelContainerHeight.constant = CGFloat(ingredientHeight + 8)
        ingredientsLabelContainerHeight.isActive = true
        
        presenter = StepListPresenter(self)
        presenter.setUpView(recipe: currentRecipe)
    }
    
    func showSpannableRecipeIngredientsText(_ spannableString: NSAttributedString) {
        ingredientListLabel.attributedText = spannableString
    }
}


// Mark - StepListViewController: UITableViewDataSource, UITableViewDelegate
extension StepListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.currentRecipe.steps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeStepCell", for: indexPath) as! RecipeStepTableViewCell
        let row = (indexPath as NSIndexPath).row
        let step = currentRecipe.steps[row]
        
        cell.stepTitle.text = "\(row). \(step.shortDescription)"
        cell.playImageButton.isHidden = step.videoURL.count == 0
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        let backgroundView = UIView()
        
        backgroundView.backgroundColor = UIColor(red:0.98, green:0.67, blue:0.58, alpha:1.0)
        backgroundView.layer.masksToBounds = true
        backgroundView.layer.cornerRadius  = 2.5
        
        let row = (indexPath as NSIndexPath).row
        let step = currentRecipe.steps[row]
        
        if step.videoURL.count == 0 {
            return
        }
        
        cell?.selectedBackgroundView = backgroundView
        
        if step.videoURL.count != 0 {
            let viewPagerController = self.instantiateViewController(withIdentifier: "RecipeStepsViewPagerController", from: "Main") as! RecipeStepsViewPagerController
            
            viewPagerController.currentRecipe = self.currentRecipe
            viewPagerController.selectedStepIndex = row
            
            self.navigationController?.pushViewController(viewPagerController, animated: true)
        }
    }
}
