//
//  PersistenceController.swift
//  glucosio
//
//  Created by Eugenio Baglieri on 17/08/16.
//  Copyright © 2016 Eugenio Baglieri. All rights reserved.
//

import Foundation

class PersistenceController {
    
    static let sharedInstance: PersistenceController = PersistenceController()
    
    private(set) lazy var currentUser: User = {
        
        return self.loadUser() ?? User()
    }()
    
    private init() {}
    
    private func loadUser() -> User? {
        
        let ud = UserDefaults.standard
        
        if let encodedUser = ud.object(forKey: kGLUCUserPreferenceKey) as? Data {
        
            return NSKeyedUnarchiver.unarchiveObject(with: encodedUser) as? User
        } else {
        
            return nil
        }
    }
    
    func saveUser(user: User) {
        
        let encodedUser = NSKeyedArchiver.archivedData(withRootObject: user)
        
        let ud = UserDefaults.standard
        
        ud.set(encodedUser, forKey: kGLUCUserPreferenceKey)
        
        ud.synchronize()
    }
}
