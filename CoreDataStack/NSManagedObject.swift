//
//  NSManagedObject+Utilities.swift
//  CoreDataStack
//
//  Created by Eugenio Baglieri on 07/05/15.
//  Copyright (c) 2015 Eugenio Baglieri. All rights reserved.
//

import Foundation
import CoreData

public extension NSManagedObject {
    
    public class func createInContext(context: NSManagedObjectContext) -> Self {
        return createInContext(context, type: self)
    }
    
    private class func createInContext<T:NSManagedObject>(context: NSManagedObjectContext, type: T.Type) -> T {
        let className = entityName()
        let object = NSEntityDescription.insertNewObjectForEntityForName(className, inManagedObjectContext: context) as! T
        return object
    }
    
    public class func entityName() -> String {
        let classString = NSStringFromClass(self)
        // The entity is the last component of dot-separated class name:
        let components = classString.characters.split{ $0 == "." }.map { String($0) }
        assert(components.count > 0, "Failed extract class name from \(classString)")
        return components.last!
    }
    
    public func delete() {
        guard let context = managedObjectContext else {
            assertionFailure("Can't delete object beacuse it's not registerd with any NSManagedObjectContext")
            abort()
        }
        context.performBlock {
            context.deleteObject(self)
        }
    }
}