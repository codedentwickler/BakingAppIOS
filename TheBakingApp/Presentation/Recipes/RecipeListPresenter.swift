//
//  RecipeListPresenter.swift
//  TheBakingApp
//
//  Created by codedentwickler on 1/25/18.
//  Copyright © 2018 codedentwickler. All rights reserved.
//

import Foundation

protocol RecipeListView: BaseView {
    
    func showRecipes(_ recipes: [Recipe])
}

class RecipeListPresenter: BasePresenter {
    
    weak private var view: RecipeListView?
    
    init(_ view: RecipeListView) {
        self.view = view
    }
    
    func detachView() {
        self.view = nil
    }
    
    func loadRecipes() {
        
        if LocalStorage.shared.contains(key: PersistenceIdentifiers.RECIPE_RESPONSE) {
            let recipes = LocalStorage.shared.getObject(key: PersistenceIdentifiers.RECIPE_RESPONSE) as! [Recipe]
            self.view?.showRecipes(recipes)

            return
        }
        self.view?.showLoading(withMessage: "Loading Recipes...")
        ApiCalls.getRecipes { (response, error) in
            self.view?.dismissLoading()
            guard error == nil else {
                self.view?.showError(message: (error?.localizedDescription)!)
                return
            }
            if let response = response {
                // Persist static recipes response when loaded first, no need to fetch same content every time
                LocalStorage.shared.persistObject(object: response as NSObject, key: PersistenceIdentifiers.RECIPE_RESPONSE)
                self.view?.showRecipes(response)
            }
        }
    }
}
