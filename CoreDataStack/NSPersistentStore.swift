//
//  NSPersistentStore.swift
//  EBCoreDataStack
//
//  Created by Eugenio Baglieri on 10/09/15.
//  Copyright © 2015 Eugenio Baglieri. All rights reserved.
//

import CoreData

public extension NSPersistentStore {
    
    public class func URLForSQLiteStoreName(storeName: String, inDirectory directory: NSSearchPathDirectory? = nil) -> NSURL {
        
        assert(storeName.characters.count > 0, "Store name must be longer then zero characters.")
        
        let dir = directory ?? .DocumentDirectory
        
        do {
            let directoryURL = try NSFileManager.defaultManager().URLForDirectory(dir, inDomain: .AllDomainsMask, appropriateForURL: nil, create: true)
            return directoryURL.URLByAppendingPathComponent(storeName + ".sqlite", isDirectory: false)
        } catch let error as NSError {
            log.error(error)
            abort()
        }
    }
    
}
