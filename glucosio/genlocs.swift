#!/usr/bin/swift
//
//  genlocs.swift
//  glucosio
//
//  Created by Eugenio Baglieri on 17/08/16.
//  Copyright © 2016 Eugenio Baglieri. All rights reserved.
//

import Foundation


import Foundation

guard Process.arguments.count == 2 else {
    print("Syntax: genstrings [Localizable.strings]")
    exit(0)
}

guard let fileContent = try? String(contentsOfFile: Process.arguments[1]) else {
    print("Invalid Localizable.plist file provided")
    exit(0)
}

let contentDictionary = fileContent.propertyListFromStringsFileFormat()

print("struct L10n {\n" )

for (key, value) in contentDictionary {
    
    var keyComponents = key.components(separatedBy: CharacterSet(charactersIn:"._-"))
    
    var renamedKey = ""
    
    for (index, value) in keyComponents.enumerated() {
        
        renamedKey += (index == 0) ? value.lowercased() : value.capitalized
        
    }
    
    print("\tstatic let \(renamedKey) = \"\(key)\" \n")
    
}

print("}")

