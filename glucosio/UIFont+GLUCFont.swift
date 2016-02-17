//
//  UIFont+GLUCFont.swift
//  glucosio
//
//  Created by Eugenio Baglieri on 13/02/16.
//  Copyright © 2016 Eugenio Baglieri. All rights reserved.
//

import UIKit

extension UIFont {
    
    convenience init(glucFont: GLUCAppereance.Font, size fontSize: CGFloat) {
        self.init(name: glucFont.rawValue, size: fontSize)!
    }
}
