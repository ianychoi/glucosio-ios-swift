//
//  StoryboardInstantiable.swift
//  glucosio
//
//  Created by Eugenio Baglieri on 19/09/16.
//  Copyright © 2016 Eugenio Baglieri. All rights reserved.
//

import UIKit

protocol StoryboardInstantiable: class {
    static var storyboardIdentifier: String {get}
    static func instantiate(fromStoryboardNamed name: GLUCStoryboard) -> Self
    static func instantiate(fromStoryboard storyboard: UIStoryboard) -> Self
}
