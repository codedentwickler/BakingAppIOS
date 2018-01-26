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
        recipePresenter = RecipeListPresenter(self)
        recipePresenter.loadRecipes()
    }
    
    func showRecipes(_ recipes: [Recipe]) {
        self.recipes = recipes
    }
}

// Mark - RecipeListViewController: UITableViewDataSource, UITableViewDelegate
extension RecipeListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard recipes != nil else {
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
    
}
