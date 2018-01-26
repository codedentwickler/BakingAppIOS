//
//  ReachabilityManager.swift
//  TheBakingApp
//
//  Created by codedentwickler on 1/25/18.
//  Copyright © 2018 codedentwickler. All rights reserved.
//

import Foundation
import Reachability

class ReachabilityManager: NSObject {
    
    //MARK: - Properities
    
    var reachability: Reachability?
    let reachabilityChangedNotification = "ReachabilityChangedNotification"
    let errorManager = ErrorManager()
    
    //MARK: - Manager
    
    class var sharedManager: ReachabilityManager {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: ReachabilityManager? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = ReachabilityManager()
        }
        
        return Static.instance!
    }
    
    //MARK: - Lifecycle
    
    override init() {
        super.init()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ReachabilityManager.reachabilityChanged), name: reachabilityChangedNotification, object: reachability)
        do {
            self.reachability = try Reachability.reachabilityForInternetConnection()
            try self.reachability?.startNotifier()
        } catch {
            logger.info("\(APPNAME) Reachability failed")
            return
        }
    }
    
    @objc func reachabilityChanged(notification: NSNotification) {
        weak var weakSelf = self
        let reachability = notification.object as! Reachability
        
        if reachability.isReachable() {
            logger.info("\(APPNAME) Reachability: Reachable")
        } else {
            weakSelf?.errorManager.handleReachability()
            logger.info("\(APPNAME) Reachability: Not reachable")
        }
    }
    
    //MARK: - Class Methods
    
    static func isReachable() -> Bool{
        return ReachabilityManager.sharedManager.reachability!.isReachable()
    }
    
    static func isUnreachable() -> Bool {
        return !(ReachabilityManager.sharedManager.reachability!.isReachable())
    }
    
    static func isReachableViaWWAN() -> Bool{
        return ReachabilityManager.sharedManager.reachability!.isReachableViaWWAN()
    }
    
    static func isReachableViaWiFi() ->Bool{
        return ReachabilityManager.sharedManager.reachability!.isReachableViaWiFi()
}


