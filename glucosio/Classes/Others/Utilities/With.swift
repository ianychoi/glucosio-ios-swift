//
//  With.swift
//  glucosio
//
//  Created by Eugenio Baglieri on 13/02/16.
//  Copyright © 2016 Eugenio Baglieri. All rights reserved.
//

/**
Executes a series of statements that refers to the same item, without needing of specify it's entire name.
For example to change multiple properties of an object

- parameter item:  The item, it can be an object or structure or something else.
- parameter block: The block that contains statements that refers to item
*/
public func with<T>(_ item: T, do block: (T) -> Void) {
    block(item)
}
