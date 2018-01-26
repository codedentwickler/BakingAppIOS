//
//  ApiCalls.swift
//  TheBakingApp
//
//  Created by codedentwickler on 1/26/18.
//  Copyright © 2018 codedentwickler. All rights reserved.
//

import Foundation
import Alamofire
import EVReflection

struct ApiCalls {
    
    static func getRecipes(completion: @escaping (_ result: [Recipe]?, _ error: Error?) -> Void) {
        
        Alamofire.request(ApiEndpoints.recipes(), method: .get)
            .validate()
            .responseArray { (response: DataResponse<[Recipe]>) in
                
                switch response.result {
                    case .success:
                        if let data = response.result.value {
                            print(data)
                            print("Request: \(response.request)")
                            print("HTTP Response: \(response.response)")
                            completion(data, nil)
                    }
                    
                    case .failure(let error):
                        print("Error Occured while loading Recipes \(error)")
                        completion(nil, error)
                    
                }
            }
        
    }
}
