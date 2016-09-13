//
//  PickerController.swift
//  glucosio
//
//  Created by Eugenio Baglieri on 12/09/16.
//  Copyright © 2016 Eugenio Baglieri. All rights reserved.
//

import UIKit

protocol PickerControllerDelegate: class {
    
    func pickerController<Picker, PickingItem>(_ picker:Picker, didFinishPickingItem item: PickingItem)
    func pickerControllerDidCancel<Picker>(_ picker: Picker)
}

class PickerController<Item>: UIViewController {

    var pickerDelegate: PickerControllerDelegate?
    
}
