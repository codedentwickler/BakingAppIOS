//
//  ApiEndPoints.swift
//  TheBakingApp
//
//  Created by codedentwickler on 1/26/18.
//  Copyright © 2018 codedentwickler. All rights reserved.
//

import Foundation

struct ApiEndpoints {
    
    static let BASE_URL = "https://go.udacity.com"

    static func recipes() -> String {
        return "\(BASE_URL)/android-baking-app-json"
    }

    
}
