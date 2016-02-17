//
//  Types.swift
//  EBCoreDataStack
//
//  Created by Eugenio Baglieri on 09/09/15.
//  Copyright © 2015 Eugenio Baglieri. All rights reserved.
//

import CoreData

public enum CDResult{
    case Success
    case Failure(NSError)
}

public typealias CDCompletionHandler = (result: CDResult) -> Void