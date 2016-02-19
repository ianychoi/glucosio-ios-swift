//
//  Reading+CoreDataProperties.swift
//  glucosio
//
//  Created by Eugenio Baglieri on 17/02/16.
//  Copyright © 2016 Eugenio Baglieri. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Reading {

    @NSManaged var value: NSNumber?
    @NSManaged var readingTypeId: NSNumber?
    @NSManaged var notes: String?
    @NSManaged var readingCustomTypeName: String?

}
