//
//  UIViewController+StoryboardInstantiable.swift
//  glucosio
//
//  Created by Eugenio Baglieri on 19/09/16.
//  Copyright © 2016 Eugenio Baglieri. All rights reserved.
//

import UIKit

extension UIViewController: StoryboardInstantiable {
    
    static var storyboardIdentifier: String {
        //Get the name of current class
        let classString = NSStringFromClass(self)
        let components = classString.components(separatedBy: ".")
        assert(components.count > 1, "Failed extract class name from \(classString)")
        return components.last!
    }
    
    static func instantiate(fromStoryboard storyboard: UIStoryboard) -> Self {
        return instantiate(fromStoryboard: storyboard, type: self)
    }
    
    static func instantiate(fromStoryboardNamed name: GLUCStoryboard) -> Self {
        let storyboard = UIStoryboard(name: name)
        return instantiate(fromStoryboard: storyboard, type: self)
    }
}

extension UIViewController {
    
    // Thanks to generics, return automatically the right type
    fileprivate class func instantiate<T: UIViewController>(fromStoryboard storyboard: UIStoryboard, type: T.Type) -> T {
        return storyboard.instantiateViewController(withIdentifier: self.storyboardIdentifier) as! T
    }
}
