//
//  AppereanceConstants.swift
//  glucosio
//
//  Created by Eugenio Baglieri on 13/02/16.
//  Copyright © 2016 Eugenio Baglieri. All rights reserved.
//

import UIKit

struct GLUCColor {
    
    static let pink = UIColor(hex: 0xE84579, alpha: 1)
    
    static let green = UIColor(hex: 0x46A644, alpha: 1)
}

struct GLUCFont {
    
    static let regularFontName = "Lato-Regular"
    
    static let boldFontName = "Lato-Bold"
    
    static let regular = UIFont(name: regularFontName, size: UIFont.systemFontSize)!
    
    static let bold = UIFont(name: boldFontName, size: UIFont.systemFontSize)!
}

enum GLUCAsset: String {
    
    case history = "HystoryIcon"
    
    case overview = "OverviewIcon"
    
    case settings = "SettingsIcon"
}

extension GLUCAsset {
    
    func image() -> UIImage {
        return UIImage(asset: self)
    }
}



/// Additional storyboards of the projects (other than main)
/// if you add a new storyboard you should add a new case
///
/// - LaunchScreen: LaunchScreen storyboard
/// - Pickers:      Pickers Storyboard
enum GLUCStoryboard: String {
    case LaunchScreen
    case Pickers
}
