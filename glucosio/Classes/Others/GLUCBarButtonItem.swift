//
//  GLUCBarButtonItem.swift
//  glucosio
//
//  Created by Eugenio Baglieri on 08/09/16.
//  Copyright © 2016 Eugenio Baglieri. All rights reserved.
//

import UIKit

class GLUCBarButtonItem: UIBarButtonItem {
    
    public convenience init(systemItem: UIBarButtonSystemItem, target: Any?, action: Selector?) {
        self.init(barButtonSystemItem: systemItem, target: target, action: action)
        switch systemItem {
        case .done, .save:
            self.setTitleTextAttributes([NSFontAttributeName : GLUCFont.bold], for: .normal)
        default:
            self.setTitleTextAttributes([NSFontAttributeName : GLUCFont.regular], for: .normal)
        }
    }
    
}
