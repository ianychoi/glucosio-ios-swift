//
//  DataSource.swift
//  glucosio
//
//  Created by Eugenio Baglieri on 08/09/16.
//  Copyright © 2016 Eugenio Baglieri. All rights reserved.
//

import UIKit

class ArrayDataSource<CellType: UITableViewCell, ItemType>: NSObject, UITableViewDataSource {
    
    typealias CellConfigurationBlock = (CellType?, ItemType) -> Void
    
    private var items: [ItemType]
    
    private var cellReuseIdentifier: String
    
    private weak var table: UITableView?
    
    var configureCellBlock: CellConfigurationBlock?
    
    init(tableView: UITableView, items: [ItemType], cellReuseIdentifier: String) {
        
        self.items = items
        self.cellReuseIdentifier = cellReuseIdentifier
        table = tableView
        
        super.init()
        tableView.dataSource = self
    }
    
    
    func itemAtIndexPath(_ indexPath: IndexPath) -> ItemType {
        return self.items[indexPath.row]
    }
    
    func configureCell(_ cell: CellType, atIndexPath indexPath:IndexPath) {
        let item = itemAtIndexPath(indexPath)
        configureCellBlock?(cell, item)
    }
    
    // MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if items.count <= 0 {
            return 0
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! CellType
        
        configureCell(cell, atIndexPath: indexPath)
        
        return cell as UITableViewCell
    }

}
    
