//
//  Recipe.swift
//  TheBakingApp
//
//  Created by codedentwickler on 1/25/18.
//  Copyright © 2018 codedentwickler. All rights reserved.
//

import Foundation
import EVReflection

public class Recipe: EVNetworkingObject {
    
    var id: Int = -1
    var name: String = ""
    var ingredients: [Ingredient] = [Ingredient]()
    var steps: [Step] = [Step]()
    var servings: Int = -1
    var image: String = ""
}

public class Ingredient: EVNetworkingObject {
    
    var ingredient: String = ""
    var measure: String = ""
    var quantity: Int = -1
}

public class Step: EVNetworkingObject {
    
    var id: Int = -1
    var shortDescription: String = ""
    var videoURL: String = ""
    var thumbnailURL: String = ""
}
