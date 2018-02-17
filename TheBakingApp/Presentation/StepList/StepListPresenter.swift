//
//  StepListPresenter.swift
//  TheBakingApp
//
//  Created by codedentwickler on 2/13/18.
//  Copyright © 2018 codedentwickler. All rights reserved.
//

import Foundation
import UIKit

protocol RecipeStepsView: BaseView {
    
    func showSpannableRecipeIngredientsText(_ spannableString: NSAttributedString)
}

class StepListPresenter: BasePresenter {
    
    weak private var view: RecipeStepsView?
    
    init(_ view: RecipeStepsView) {
        self.view = view
    }
    
    func detachView() {
        self.view = nil
    }
    
    func setUpView(recipe: Recipe) {
        self.view?.showSpannableRecipeIngredientsText(self.buildSpannableIngredientsText(recipe: recipe))
    }
    
    func buildSpannableIngredientsText(recipe: Recipe) -> NSAttributedString {
        let array: [String] = recipe.ingredients.map({ "\($0.ingredient) (\($0.quantity) \($0.measure))" })
        
        let attributedString = NSMutableAttributedString(string: "List of Ingredients\n\n")
        attributedString.addAttributes([
            .font: UIFont.systemFont(ofSize: 16.0, weight: .bold),
            .foregroundColor: UIColor.black
            ], range: NSRange(location: 0, length: attributedString.string.count))
        
        let attributedStringBody = StringHelper.createBulletedList(fromStringArray: array, font: UIFont.systemFont(ofSize: 15))
        attributedString.append(attributedStringBody)
        
        return attributedString
    }
}
