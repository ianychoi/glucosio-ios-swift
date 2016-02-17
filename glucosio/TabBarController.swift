//
//  TabBarController.swift
//  glucosio
//
//  Created by Eugenio Baglieri on 17/02/16.
//  Copyright © 2016 Eugenio Baglieri. All rights reserved.
//

import UIKit


class TabBarController: UITabBarController {

    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: Private Methods
    
    private func setupUI() {
        
        /**
        *  changing the unselected image color, you should change the selected image
        *  color if you want them to be different
        */
        
        tabBar.items?.forEach {
            if let currentImage = $0.image {
                $0.image = currentImage.imageWithRenderingMode(.AlwaysOriginal)
            }
        }
    }

}