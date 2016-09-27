//
//  String+Localization.swift
//  glucosio
//
//  Created by Eugenio Baglieri on 17/08/16.
//  Copyright © 2016 Eugenio Baglieri. All rights reserved.
//

import Foundation

extension String {

    var localized: String {
    
        var retVal = NSLocalizedString(self, comment: "")
        
        //check if no localization exists, print a log line and fall back to base localization
        if retVal == self {
            
            let deviceLanguage = NSLocale.preferredLanguages.first!
            
            print("Missing \"\(deviceLanguage)\" localization for \"\(self)\" key")
            
            let bundle: Bundle
            
            if let pathToBase = Bundle.main.path(forResource: "Base", ofType: "lproj"),
                let _bundle = Bundle(path: pathToBase) {
                
                bundle = _bundle
            
            } else {
                
                bundle = Bundle.main
            }
            
            retVal = bundle.localizedString(forKey: self, value: self, table: nil)
            
        }
        
        return retVal
    }

}
