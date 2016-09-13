//
//  ListPickerViewController.swift
//  glucosio
//
//  Created by Eugenio Baglieri on 07/09/16.
//  Copyright © 2016 Eugenio Baglieri. All rights reserved.
//

import UIKit

class ListPickerController<ItemType>: UINavigationController {
    
    typealias ListPickerCompletion = (_ picker: ListPickerController, _ pickedValue: ItemType) -> Void
    
    typealias ListPickerCancellation = (_ picker: ListPickerController) -> Void
    
    typealias ItemDisplayNameTransform = (_ item: ItemType) -> String
    
    /// This is a var implicitly unwrapped cause of init hierarchy
    private var internalPicker: InternalListPickerController<ItemType>!
    
    var onPickerDidFinish: ListPickerCompletion?
    
    var onPickerDidCancel: ListPickerCancellation?
    
    var onDisplayItem: ItemDisplayNameTransform?
    
    var finishOnPicking: Bool! {
        get { return internalPicker.finishOnPicking }
        set { internalPicker.finishOnPicking = newValue }
    }
    
    // MARK: Inits
    
    convenience init(items: [ItemType]) {
        let picker = InternalListPickerController(items: items)
        self.init(rootViewController: picker)
        picker.pickerParent = self
        internalPicker = picker
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    fileprivate func internalPickerWantsCancel() {
        onPickerDidCancel?(self)
    }
    
    fileprivate func internalPickerDidPickedItem(_ item: ItemType) {
        onPickerDidFinish?(self, item)
    }
    
    fileprivate func internalPickerWantsDisplayItem(_ item: ItemType) -> String {
        return onDisplayItem?(item) ?? "\(item)"
    }

}

private class InternalListPickerController<ItemType>: UIViewController, UITableViewDelegate {
    
    var finishOnPicking: Bool! {
        didSet {
            navigationItem.rightBarButtonItem = (finishOnPicking == false) ? doneBarButton: nil
        }
    }
    
    var pickerParent: ListPickerController<ItemType>!
    
    private let listItems: [ItemType]
    
    private var dataSource: ArrayDataSource<UITableViewCell, ItemType>!
    
    private var pickedItem: ItemType!
    
    private var cellIdenfier = "ListPickerCell"
    
    private lazy var doneBarButton: GLUCBarButtonItem = {
        let button = GLUCBarButtonItem(systemItem: .done, target: self, action: #selector(doneButtonClicked(_:)))
        return button
    }()
    
    private lazy var cancelBarButton: GLUCBarButtonItem = {
        let button = GLUCBarButtonItem(systemItem: .cancel, target: self, action: #selector(cancelButtonClicked(_:)))
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        return table
    }()
    
    //MARK: - Initialization
    
    init(items: [ItemType]) {
        finishOnPicking = false
        listItems = items
        super.init(nibName: nil, bundle: nil)
    }
    
    private init() {
        listItems = []
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = cancelBarButton
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdenfier)
        configureDataSource()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    // MARK: - Private methods
    
    private func configureDataSource() {
        dataSource = ArrayDataSource(tableView: tableView, items: listItems, cellReuseIdentifier: cellIdenfier)
        dataSource.configureCellBlock = { [unowned self] (cell, item) in
            cell?.selectionStyle = .none
            cell?.accessoryType = .none
            cell?.textLabel?.text = self.pickerParent.internalPickerWantsDisplayItem(item)
        }
    }
    
    @objc private func doneButtonClicked(_ button: UIBarButtonItem) {
        pickerParent.internalPickerDidPickedItem(pickedItem)
    }
    
    @objc private func cancelButtonClicked(_ button: UIBarButtonItem) {
        pickerParent.internalPickerWantsCancel()
    }
    
    // MARK: - UITableViewDelegate
    
    fileprivate func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath);
        selectedCell?.accessoryType = .checkmark
        pickedItem = dataSource.itemAtIndexPath(indexPath)
        
        if finishOnPicking == true {
            pickerParent.internalPickerDidPickedItem(pickedItem)
        }
        
    }
    
    fileprivate func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let deselectedCell = tableView.cellForRow(at: indexPath)
        deselectedCell?.accessoryType = .none
    }
}
