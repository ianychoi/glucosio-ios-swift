//
//  NSManagedObjectModel.swift
//  EBCoreDataStack
//
//  Created by Eugenio Baglieri on 10/09/15.
//  Copyright © 2015 Eugenio Baglieri. All rights reserved.
//

import CoreData

public extension NSManagedObjectModel {
    
    public convenience init(resourceNamed modelName: String, inBundle bundle: NSBundle) {
        
        guard let modelURL = bundle.URLForResource(modelName, withExtension: "momd") else {
            assertionFailure("ManagedObjectModel \(modelName) not found in bundle.")
            abort()
        }
        self.init(contentsOfURL: modelURL)!
    }
    
}
