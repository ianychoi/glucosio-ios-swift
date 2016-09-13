//
//  TabBarController.swift
//  glucosio
//
//  Created by Eugenio Baglieri on 17/02/16.
//  Copyright © 2016 Eugenio Baglieri. All rights reserved.
//

import UIKit


class TabBarController: UITabBarController {

    private let tabTitles = [L10n.tabOverview,
                             L10n.tabHistory,
                             L10n.actionSettings]
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    // MARK: Private Methods
    
    private func setupTabBar() {
        
        /**
        *  changing the unselected image color, you should change the selected image
        *  color if you want them to be different
        */
        
        if let tabs = tabBar.items {
            
            for (index, tab) in tabs.enumerated() {
                
                if let currentImage = tab.image {
                    tab.image = currentImage.withRenderingMode(.alwaysOriginal)
                }
                tab.title = tabTitles[index].localized()
            }
        }
    }

}
