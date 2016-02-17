//
//  NSPersistentStoreCoordinator.swift
//  EBCoreDataStack
//
//  Created by Eugenio Baglieri on 10/09/15.
//  Copyright © 2015 Eugenio Baglieri. All rights reserved.
//

import CoreData

public extension NSPersistentStoreCoordinator {
    
    public convenience init(persistentStoreURL: NSURL, managedObjectModel: NSManagedObjectModel) {
        self.init(managedObjectModel: managedObjectModel)
        self.addSQLitePersistentStoreWithURL(persistentStoreURL)
    }
    
    private func addSQLitePersistentStoreWithURL(url: NSURL) {
        
        do {
            try addStore(url)
        } catch let error as NSError {
            
            // Check for version mismatch
            if (error.domain == NSCocoaErrorDomain && (error.code == NSPersistentStoreIncompatibleVersionHashError || error.code == NSMigrationMissingSourceModelError)) {
                
                log.warning("Model mismatch, removing persistent store...")
                
                let fileManager = NSFileManager.defaultManager()
                
                if fileManager.fileExistsAtPath(url.path!) {
                    do {
                        try fileManager.removeItemAtURL(url)
                        log.info("Persistent store removed successfully!")
                    } catch let error as NSError {
                        log.error(error)
                        abort()
                    }
                }
                
                do {
                    try addStore(url)
                } catch let error as NSError{
                    log.error("Second attempt to add the persistent store failed with error code \(error.code): \(error.localizedDescription)")
                    abort()
                }
            }
        }
        
    }
    
    private func addStore(url: NSURL) throws {
        let persistentStoreOptions = [
            NSInferMappingModelAutomaticallyOption : NSNumber(bool: true),
            NSMigratePersistentStoresAutomaticallyOption : NSNumber(bool: true),
            NSSQLitePragmasOption : ["synchronous" : "OFF"]
        ]
        
        do {
            try addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: persistentStoreOptions)
        } catch let error as NSError {
            throw error
        }
    }
    
}
