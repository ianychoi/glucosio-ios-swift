//
//  AppereanceConstants.swift
//  glucosio
//
//  Created by Eugenio Baglieri on 13/02/16.
//  Copyright © 2016 Eugenio Baglieri. All rights reserved.
//

import UIKit

struct GLUCAppereance {
    
    enum Color: UInt32 {
        case Pink = 0xFF047B
        case Green = 0x46A600
        //case Yellow = 0xFEE513
        //case White = 0xFFFFFF
    }
    
    enum Font: String {
        case Regular = "Lato-Regular"
        case Bold = "Lato-Bold"
    }
    
    enum Asset: String {
        case HystoryIcon
        case OverviewIcon
        case SettingsIcon
    }
}



extension GLUCAppereance.Color {

    func color() -> UIColor {
        return UIColor(glucColor: self, alpha: 1.0)
    }
    
}



extension GLUCAppereance.Font {
    
    var font: UIFont {
        return UIFont(glucFont: self, size: UIFont.systemFontSize())
    }
    
    static func defaultFont() -> UIFont {
        return GLUCAppereance.Font.Regular.font
    }
    
    
    static func defaultBoldFont() -> UIFont {
        return GLUCAppereance.Font.Bold.font
    }
}

extension GLUCAppereance.Asset {
    
    func image() -> UIImage {
        return UIImage(asset: self)
    }
    
}
