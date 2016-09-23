//
//  ListPickerController.swift
//  glucosio
//
//  Created by Eugenio Baglieri on 20/09/16.
//  Copyright © 2016 Eugenio Baglieri. All rights reserved.
//

import UIKit

class ListPickerController<ItemType>: PickerController, UITableViewDelegate {

    typealias ListPickerCompletion = (_ pickedValue: ItemType) -> Void
    typealias ListPickerCancellation = () -> Void
    typealias ListPickerDisplayNameTransform = (_ item: ItemType) -> String
    
    fileprivate var onPickerDidFinish: ListPickerCompletion?
    fileprivate var onPickerDidCancel: ListPickerCancellation?
    fileprivate var onDisplayItem: ListPickerDisplayNameTransform?
    fileprivate var dataSource: ArrayDataSource<UITableViewCell, ItemType>!
    fileprivate var pickedItem: ItemType!
    fileprivate var cellIdenfier = "ListPickerCell"
    
    fileprivate lazy var tableView: IntrinsicSizedTableView = {
        let table = IntrinsicSizedTableView()
        table.tableHeaderView = UITableView()
        table.tableFooterView = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: self.cellIdenfier)
        table.delegate = self
        return table
    }()
    
    var finishOnPicking: Bool {
        didSet {
            navigationItem.rightBarButtonItem = (finishOnPicking == false) ? doneBarButton: nil
        }
    }
    
    var listItems: [ItemType]
    
    //MARK: - Initialization
    
    init(items: [ItemType]) {
        finishOnPicking = true
        listItems = items
        super.init()
    }
    
    fileprivate override init() {
        finishOnPicking = false
        listItems = []
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        view.addSubview(tableView)
        configureAutoLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cancelBarButton.target = self
        cancelBarButton.action = #selector(cancelButtonClicked(_:))
        
        doneBarButton.target = self
        doneBarButton.action = #selector(doneButtonClicked(_:))
        
        navigationItem.rightBarButtonItem = (finishOnPicking == false) ? doneBarButton: nil
        
        configureDataSource()
    }
    
    // MARK: - Public methods
    
    func setOnPickerDidFinish(_ block: ListPickerCompletion?) {
        onPickerDidFinish = block
    }
    
    func setOnPickerDidCancel(_ block: ListPickerCancellation?) {
        onPickerDidCancel = block
    }
    
    func setOnPickerWillDisplayItem(_ block: ListPickerDisplayNameTransform?) {
        onDisplayItem = block
    }
    
    // MARK: - Private methods
    
    fileprivate func configureAutoLayout() {
        
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[tableView]|", options: [], metrics: nil, views: ["tableView" : tableView])
        let verticalContstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[navBar][tableView][bottomGuide]", options: [], metrics: nil,
                                                                  views: [
                                                                    "navBar" : navigationBar,
                                                                    "tableView" : tableView,
                                                                    "bottomGuide" : bottomLayoutGuide
            ])
        view.addConstraints(horizontalConstraints)
        view.addConstraints(verticalContstraints)
    }
    
    fileprivate func configureDataSource() {
        dataSource = ArrayDataSource(tableView: tableView, items: listItems, cellReuseIdentifier: cellIdenfier)
        dataSource.configureCellBlock = { [unowned self] (cell, item) in
            cell?.selectionStyle = .none
            cell?.accessoryType = .none
            cell?.textLabel?.font = GLUCFont.regular
            cell?.textLabel?.text = self.onDisplayItem?(item) ?? "\(item)"
        }
    }
    
    // MARK - Button actions
    @objc private func doneButtonClicked(_ button: UIBarButtonItem) {
        onPickerDidFinish?(pickedItem)
    }
    
    @objc private func cancelButtonClicked(_ button: UIBarButtonItem) {
        onPickerDidCancel?()
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedCell = tableView.cellForRow(at: indexPath);
        selectedCell?.accessoryType = .checkmark
        
        pickedItem = dataSource.itemAtIndexPath(indexPath)
        
        // Use of async dispatch resolve this: http://stackoverflow.com/questions/21075540/presentviewcontrolleranimatedyes-view-will-not-appear-until-user-taps-again/30787046#30787046
        DispatchQueue.main.async {
            if self.finishOnPicking == true {
                self.onPickerDidFinish?(self.pickedItem)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let deselectedCell = tableView.cellForRow(at: indexPath)
        deselectedCell?.accessoryType = .none
    }
    
}
