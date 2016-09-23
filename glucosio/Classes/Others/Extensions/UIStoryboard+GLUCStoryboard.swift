//
//  UIStoryboard+GLUCStoryboard.swift
//  glucosio
//
//  Created by Eugenio Baglieri on 19/09/16.
//  Copyright © 2016 Eugenio Baglieri. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    class var main: UIStoryboard {
        guard let mainStoryboardName = Bundle.main.infoDictionary?["UIMainStoryboardFile"] as? String else {
            assertionFailure("No UIMainStoryboardFile found in main bundle")
            abort()
        }
        return UIStoryboard(name: mainStoryboardName, bundle: Bundle.main)
    }
    
    convenience init(name: GLUCStoryboard) {
        self.init(name: name.rawValue, bundle: Bundle.main)
    }
}
