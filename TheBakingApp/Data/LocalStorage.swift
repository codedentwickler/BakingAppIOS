//
//  LocalStorage.swift
//  FBNInsurance
//
//  Created by codedentwickler on 2/7/18.
//  Copyright © 2018 Cotta & Cush. All rights reserved.
//

import Foundation

final class LocalStorage: NSObject {
    
    override init() {
        super.init()
    }
    
    static let shared = LocalStorage()
    
    public func persistObject(object: NSObject!, key: String!) {
        delete(key: key)
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: object)
        UserDefaults.standard.set(encodedData, forKey: key)
        UserDefaults.standard.synchronize()
    }

    public func getObject(key: String!) -> NSObject? {
        UserDefaults.standard.synchronize()
        
        if let data = UserDefaults.standard.data(forKey: key),
            let object = NSKeyedUnarchiver.unarchiveObject(with: data) as? NSObject  {
            return object
        } else {
            return nil
        }
    }
    
    public func contains(key: String!) -> Bool{
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    public func delete(key: String!){
        UserDefaults.standard.removeObject(forKey: key);
        UserDefaults.standard.synchronize();
    }
    
    public func clearAll(){
        let appDomain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: appDomain)
        UserDefaults.standard.synchronize()
    }

}
