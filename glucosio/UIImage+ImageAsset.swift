//
//  UIImage+ImageAsset.swift
//  glucosio
//
//  Created by Eugenio Baglieri on 17/02/16.
//  Copyright © 2016 Eugenio Baglieri. All rights reserved.
//

import UIKit

extension UIImage {

    convenience init(asset: GLUCAppereance.Asset) {
        self.init(named: asset.rawValue)!
    }
    
}
