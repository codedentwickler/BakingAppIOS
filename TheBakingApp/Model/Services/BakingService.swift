//
//  BakingService.swift
//  TheBakingApp
//
//  Created by codedentwickler on 1/25/18.
//  Copyright © 2018 codedentwickler. All rights reserved.
//

import Foundation
import Alamofire

class BakingService {
    
    func loadRecipes(completion: @escaping (RecipeResponse?, Error?) -> Void) {
        
        Alamofire.request(ApiRouterManager.recipes)
            .responseObject { (response: DataResponse<RecipeResponse>) in
            
                if let result = response.result.value {
                    print(result)
                    completion(result, nil)
                }
        }
    }
}
