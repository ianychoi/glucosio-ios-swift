//
//  SettingsTableViewCell.swift
//  glucosio
//
//  Created by Eugenio Baglieri on 22/09/16.
//  Copyright © 2016 Eugenio Baglieri. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    typealias CellSelectionHandler = () -> Void
    
    var onSelection: CellSelectionHandler? = nil
    
    func setOnSelectionHandler(_ block: CellSelectionHandler?) {
        onSelection = block
    }
}
