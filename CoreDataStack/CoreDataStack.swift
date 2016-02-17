//
//  CoreDataStack.swift
//  EBCoreDataStack
//
//  Created by Eugenio Baglieri on 08/09/15.
//  Copyright © 2015 Eugenio Baglieri. All rights reserved.
//

import CoreData

public class CoreDataStack {
    
    public let persistentStoreCoordinator: NSPersistentStoreCoordinator
    public let diskWriterContext: NSManagedObjectContext
    public let mainQueueContext: NSManagedObjectContext
    
    public init(persistentStoreCoordinator: NSPersistentStoreCoordinator) {
        
        self.persistentStoreCoordinator = persistentStoreCoordinator
        
        diskWriterContext = NSManagedObjectContext(persistentStoreCoordinator: self.persistentStoreCoordinator)
        
        mainQueueContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType, parentContext: diskWriterContext)
    }
    
}
