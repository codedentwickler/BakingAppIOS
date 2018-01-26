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
        
        self.view?.showLoading(withMessage: "Loading Recipes...")
        ApiCalls.getRecipes { (response, error) in
            self.view?.dismissLoading()
            guard error == nil else {
                self.view?.showError(message: (error?.localizedDescription)!)
                return
            }
            if let response = response {
                
                self.view?.showRecipes(response)
            }
        }

    }
    
}
