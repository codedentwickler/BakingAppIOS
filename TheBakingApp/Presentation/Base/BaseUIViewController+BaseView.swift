//
//  BaseUIViewController.swift
//  TheBakingApp
//
//  Created by codedentwickler on 1/25/18.
//  Copyright © 2018 codedentwickler. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD


// Mark - Generic View Setup 
extension BaseUIViewController: BaseView {
    
    func showLoading() {
        showProgressIndicator(withMessage: "Please Wait...")
    }
    
    func showLoading(withMessage text: String) {
        showProgressIndicator(withMessage: text)
    }
    
    func dismissLoading() {
        dismissProgressIndicator()
    }
    
    func showError(message text: String) {
        createAlertDialog(message: text)
    }
    
    func isNetworkConnected() {}
}

// Mark - Common View Actions
// Credits fdamilola - Akapo Damilola Francis

extension BaseUIViewController: UITextFieldDelegate {
    
    func performSegue(identifier: String) {
        OperationQueue.main.addOperation {
            [weak self] in
            self?.performSegue(withIdentifier: identifier, sender: self);
        }
    }
    
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    func setNavBarTitle(_ title: String?){
        self.navigationController?.navigationBar.topItem?.titleView = nil;
        self.tabBarController?.navigationController?.navigationBar.topItem?.titleView = nil;
        self.tabBarController?.navigationItem.rightBarButtonItem = nil;
        self.navigationController?.navigationBar.topItem?.title = title;
    }
    
    func setNormalTitle(_ title: String!){
        self.title = title;
    }
    
    func createAlertDialog(_ title: String! = "Oops!", message: String! = "An unexpected network error occurred.",
                           ltrActions: [UIAlertAction]! = [], alignLeft: Bool = false) -> Void {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert);
        
        if(ltrActions.count == 0){
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil);
            alertController.addAction(defaultAction);
        }else{
            for x in ltrActions{
                alertController.addAction(x as UIAlertAction);
            }
        }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.left
        
        if(alignLeft == true){
            let messageText = NSMutableAttributedString(
                string: message,
                attributes: [
                    NSAttributedStringKey.paragraphStyle: paragraphStyle,
                    NSAttributedStringKey.font : UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
                ]
            )
            alertController.setValue(messageText, forKey: "attributedMessage")
        }
        
        self.present(alertController, animated: true, completion: nil);
    }
}

// MARK - Progress Loading Indicator

extension BaseUIViewController {
    func showProgressIndicator(withMessage message: String) {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = message
        hud.mode = MBProgressHUDMode.indeterminate
        hud.isUserInteractionEnabled = false
        showNetworkIndicator(status: true)
    }
    
    func dismissProgressIndicator() {
        MBProgressHUD.hide(for: self.view, animated: true)
        showNetworkIndicator(status: false)
    }
    
    func showNetworkIndicator(status: Bool = true) {
        OperationQueue.main.addOperation {
            [weak self] in
            _ = self.debugDescription
            UIApplication.shared.isNetworkActivityIndicatorVisible = status;
        }
    }
}
