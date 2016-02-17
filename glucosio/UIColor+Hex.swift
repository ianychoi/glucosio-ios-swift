//
//  UIColor+Hex.swift
//  glucosio
//
//  Created by Eugenio Baglieri on 13/02/16.
//  Copyright © 2016 Eugenio Baglieri. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(glucColor color: GLUCAppereance.Color, alpha opacity: CGFloat) {
        self.init(hex: color.rawValue, alpha: opacity)
    }

    convenience init(hex: UInt32, alpha opacity: CGFloat) {
        let red   = CGFloat((hex >> 16) & 0xff) / 255.0
        let green = CGFloat((hex >> 8) & 0xff) / 255.0
        let blue  = CGFloat((hex     ) & 0xff) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: opacity)
    }

}