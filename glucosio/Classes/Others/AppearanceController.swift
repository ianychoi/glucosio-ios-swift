//
//  AppearenceController.swift
//  glucosio
//
//  Created by Eugenio Baglieri on 13/02/16.
//  Copyright © 2016 Eugenio Baglieri. All rights reserved.
//

import UIKit


//+ (void) setAppearanceDefaults {
//
//    [[UILabel appearanceWhenContainedInInstancesOfClasses:@[[UIButton class]]] setFont:[self defaultFont]];
//    [[UILabel appearanceWhenContainedInInstancesOfClasses:@[[UITextField class]]] setFont:[self valueEditorTextFieldFont]];
//



class AppearanceController {
    
    class func setAppearanceDefaults() {
        
        // MARK: UITabBar
        
        with(UITabBar.appearance(), do: {
            $0.barTintColor = GLUCColor.pink
            $0.isTranslucent = false
            $0.tintColor = UIColor.white
        })
        
        // MARK: UITabBarItem
        with(UITabBarItem.appearance(), do: {
            $0.setTitleTextAttributes(
                [NSForegroundColorAttributeName : UIColor.yellow,
                    NSFontAttributeName : GLUCFont.regular],
                for: UIControlState())
            $0.setTitleTextAttributes(
                [NSForegroundColorAttributeName : UIColor.white,
                    NSFontAttributeName : GLUCFont.regular],
                for: .selected)
        })
        
        // MARK: UINavigationBar
        with(UINavigationBar.appearance(), do: {
            $0.barTintColor = GLUCColor.pink
            $0.isTranslucent = false
            $0.tintColor = UIColor.white
            $0.titleTextAttributes = [
                NSForegroundColorAttributeName: UIColor.white,
                NSFontAttributeName : GLUCFont.regular
            ]
        })
        
        // MARK: UIBarButtonItem
        with(UIBarButtonItem.appearance(), do: {
            $0.setTitleTextAttributes(
                [NSFontAttributeName : GLUCFont.regular],
                for: .normal)
        })
        
        // MARK: UILabel
//        with(UILabel.appearance(), do: {
//            $0.font = GLUCFont.regular
//        })
        
        //MARK: UIButton
        with(UIButton.appearance(), do: {
            $0.tintColor = GLUCColor.pink
        })
        
        //MARK: UITextField
        with(UITextField.appearance(), do: {
            $0.font = GLUCFont.regular
        })
        
        //MARK: UISegmentedControl
        with(UISegmentedControl.appearance(), do: {
            $0.tintColor = GLUCColor.pink
            $0.setTitleTextAttributes(
                [NSFontAttributeName : GLUCFont.regular],
                for: .normal)
        })
        
        //MARK: UITableView
        with(UITableView.appearance(), do: {
            $0.backgroundColor = UIColor.white
        })
        
        //MARK: UITableViewCell
        with(UITableViewCell.appearance(), do: {
            $0.tintColor = GLUCColor.pink
        })
        
        //MARK: UIView
//        with(UIView.appearanceWhenContainedInInstancesOfClasses([UITabBar.self])) {
//            $0.tintColor = UIColor.yellowColor()
//        }
    }
    
}

