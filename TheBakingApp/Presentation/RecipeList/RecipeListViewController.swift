//
//  RecipeListViewController.swift
//  TheBakingApp
//
//  Created by codedentwickler on 1/25/18.
//  Copyright © 2018 codedentwickler. All rights reserved.
//

import UIKit

class RecipeListViewController: BaseUIViewController, RecipeListView {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var recipePresenter: RecipeListPresenter!
    private var recipes: [Recipe]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setNormalTitle("Recipes")
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.tableFooterView = UIView()

        recipePresenter = RecipeListPresenter(self)
        recipePresenter.loadRecipes()
    }
    
    func showRecipes(_ recipes: [Recipe]) {
        self.recipes = recipes
        self.tableView.reloadData()
    }
}

// Mark - RecipeListViewController: UITableViewDataSource, UITableViewDelegate
extension RecipeListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if recipes == nil {
            return 0
        }
        return (recipes?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)
        let recipe = recipes[(indexPath as NSIndexPath).row]
        
        cell.textLabel?.text = recipe.name
        cell.detailTextLabel?.text = "Ingredients: \(recipe.ingredients.count)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = recipes[(indexPath as NSIndexPath).row]
        
        let recipeStepsVc = self.instantiateViewController(withIdentifier: "StepListViewController", from: "Main") as! StepListViewController
        recipeStepsVc.currentRecipe = recipe
        
        self.navigationController?.pushViewController(recipeStepsVc, animated: true)
    }
    
}
