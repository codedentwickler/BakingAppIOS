//
//  ApiRouter.swift
//  TheBakingApp
//
//  Created by codedentwickler on 1/25/18.
//  Copyright © 2018 codedentwickler. All rights reserved.
//

import Foundation
import Alamofire

public enum ApiRouterManager: URLRequestConvertible {
    
    
    case recipes
    
    var method: HTTPMethod {
        switch self {
        case .recipes:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .recipes:
            return "/android-baking-app-json"
        }
    }
        
    public func asURLRequest() throws -> URLRequest {
        
        let url = try ApiRouterManager.baseURLPath.asURL()
        
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.timeoutInterval = TimeInterval(10 * 1000)
        
        return try URLEncoding.default.encode(request, with: nil)
    }
}

extension Request {
    public func debugLog() -> Self {
        #if DEBUG
            debugPrint(self)
        #endif
        return self
    }
}
