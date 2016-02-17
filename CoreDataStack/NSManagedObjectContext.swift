//
//  NSManagedObjectContext.swift
//  EBCoreDataStack
//
//  Created by Eugenio Baglieri on 09/09/15.
//  Copyright © 2015 Eugenio Baglieri. All rights reserved.
//

import CoreData

public extension NSManagedObjectContext {
    
    public convenience init(persistentStoreCoordinator: NSPersistentStoreCoordinator)
    {
        self.init(concurrencyType: .PrivateQueueConcurrencyType)
        performBlockAndWait { [unowned self] in
            self.persistentStoreCoordinator = persistentStoreCoordinator
            self.undoManager = NSUndoManager()
        }
    }
    
    public convenience init(concurrencyType: NSManagedObjectContextConcurrencyType, parentContext: NSManagedObjectContext)
    {
        self.init(concurrencyType: concurrencyType)
        performBlockAndWait { [unowned self] in
            self.parentContext = parentContext
            self.undoManager = NSUndoManager()
        }
    }
    
    public func createChildContext(concurrencyType: NSManagedObjectContextConcurrencyType) -> NSManagedObjectContext {
        return NSManagedObjectContext(concurrencyType: concurrencyType, parentContext: self)
    }
    
    public func performSaveToPersistentStoreWithCompletionHandler(completionHandler: CDCompletionHandler?) {
        performBlock {
            do {
                try self.save()
                if let parent = self.parentContext {
                    parent.performBlock {
                        parent.performSaveToPersistentStoreWithCompletionHandler(completionHandler)
                    }
                } else {
                    completionHandler?(result: CDResult.Success)
                }
            } catch let error as NSError {
                log.error(error)
                completionHandler?(result: CDResult.Failure(error))
            }
        }
    }
    
    public func performSaveWithCompletionHandler(completionHandler: CDCompletionHandler?) {
        performBlock {
            do {
                try self.save()
                completionHandler?(result: CDResult.Success)
            } catch let error as NSError {
                log.error(error)
                completionHandler?(result: CDResult.Failure(error))
            }
        }
    }
    
}
