//
//  BaseContract.swift
//  TheBakingApp
//
//  Created by codedentwickler on 1/25/18.
//  Copyright © 2018 codedentwickler. All rights reserved.
//

import Foundation

protocol BaseView: NSObjectProtocol {
    func showLoading()
    
    func showLoading(withMessage text: String)
    
    func dismissLoading()
    
    func showError(message text: String)
    
    func isNetworkConnected()
}

protocol BasePresenter {
    
    func detachView()
}
