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
        with(UITabBar.appearance()) {
            $0.barTintColor = GLUCAppereance.Color.Pink.color()
            $0.translucent = false
            $0.tintColor = UIColor.whiteColor()
        }
        
        // MARK: UITabBarItem
        with(UITabBarItem.appearance()) {
            $0.setTitleTextAttributes(
                [NSForegroundColorAttributeName : UIColor.yellowColor(),
                    NSFontAttributeName : GLUCAppereance.Font.defaultFont()],
                forState: .Normal)
            $0.setTitleTextAttributes(
                [NSForegroundColorAttributeName : UIColor.whiteColor(),
                    NSFontAttributeName : GLUCAppereance.Font.defaultFont()],
                forState: .Selected)
        }
        
        // MARK: UINavigationBar
        with(UINavigationBar.appearance()) {
            $0.barTintColor = GLUCAppereance.Color.Pink.color()
            $0.translucent = false
            $0.tintColor = UIColor.whiteColor()
            $0.titleTextAttributes = [
                NSForegroundColorAttributeName: UIColor.whiteColor(),
                NSFontAttributeName : GLUCAppereance.Font.defaultFont()
            ]
        }
        
        // MARK: UIBarButtonItem
        with(UIBarButtonItem.appearance()) {
            $0.setTitleTextAttributes(
                [NSFontAttributeName : GLUCAppereance.Font.defaultFont()],
                forState: .Normal)
        }
        
        // MARK: UILabel
        with(UILabel.appearance()) {
            $0.font = GLUCAppereance.Font.defaultFont()
        }
        
        //MARK: UIButton
        with(UIButton.appearance()) {
            $0.tintColor = GLUCAppereance.Color.Pink.color()
        }
        
        //MARK: UITextField
        with(UITextField.appearance()) {
            $0.font = GLUCAppereance.Font.defaultFont()
        }
        
        //MARK: UISegmentedControl
        with(UISegmentedControl.appearance()) {
            $0.tintColor = GLUCAppereance.Color.Pink.color()
            $0.setTitleTextAttributes(
                [NSFontAttributeName : GLUCAppereance.Font.defaultFont()],
                forState: .Normal)
        }
        
        //MARK: UITableView
        with(UITableView.appearance()) {
            $0.backgroundColor = UIColor.whiteColor()
        }
        
        //MARK: UITableViewCell
        with(UITableViewCell.appearance()) {
            $0.tintColor = GLUCAppereance.Color.Pink.color()
        }
        
        //MARK: UIView
//        with(UIView.appearanceWhenContainedInInstancesOfClasses([UITabBar.self])) {
//            $0.tintColor = UIColor.yellowColor()
//        }
    }
    
}

