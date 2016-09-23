//
//  DataSourceProtocol.swift
//  glucosio
//
//  Created by Eugenio Baglieri on 19/08/16.
//  Copyright © 2016 Eugenio Baglieri. All rights reserved.
//

import UIKit

protocol DataSourceProtocol: UITableViewDataSource {

    associatedtype Content
    associatedtype CellIdentifierConfigurationBlock
    associatedtype CellConfigurationBlock
    
    var cellConfigurationBlock: CellConfigurationBlock? {get set}
    
    var cellIdentifierConfigurationBlock: CellIdentifierConfigurationBlock? {get set}
    
    init<Content: IndexPathTrackable>(tableView: UITableView, content: Content)
    init<Content: IndexPathTrackable>(content: Content)
}

protocol IndexPathTrackable: Collection {
    
    associatedtype Item
    
    func item(at indexPath: IndexPath) -> Item

}

extension Array: IndexPathTrackable {
    
    typealias Item = Element
    
    func item(at indexPath: IndexPath) -> Element {
        return self[indexPath.row]
    }
    
}

extension Dictionary: IndexPathTrackable {
    
    typealias Item = Element
    
    func item(at indexPath: IndexPath) -> Element {
        
        let allKeys = Array(keys)
        
        let selectedKey = allKeys[indexPath.row]
        
        return (key: selectedKey, value: self[selectedKey]!)
    }
    
}
