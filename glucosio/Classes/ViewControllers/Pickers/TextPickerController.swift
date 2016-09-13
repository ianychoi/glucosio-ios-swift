//
//  TextPickerController.swift
//  glucosio
//
//  Created by Eugenio Baglieri on 10/09/16.
//  Copyright © 2016 Eugenio Baglieri. All rights reserved.
//

import UIKit

class TextPickerController: UINavigationController {
    
    typealias TextPickerCompletion = (_ picker: TextPickerController, _ pickedText: String) -> Void
    
    typealias TextPickerCancellation = (_ picker: TextPickerController) -> Void
    
    /// This is a var implicitly unwrapped cause of init hierarchy
    private var internalPicker: InternalPickerController<ItemType>!
    
    var onPickerDidFinish: ListPickerCompletion?
    
    var onPickerDidCancel: ListPickerCancellation?
    
    // MARK: Inits
    
    convenience init() {
        let picker = InternalPickerController()
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
    
}

private class InternalTextPickerController: UIViewController {
    
    var pickerParent: ListPickerController<ItemType>!
    
    private var pickedText: String!
    
    private lazy var cancelBarButton: GLUCBarButtonItem = {
        let button = GLUCBarButtonItem(systemItem: .cancel, target: self, action: #selector(cancelButtonClicked(_:)))
        return button
    }()
    
    //MARK: - Initialization
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = cancelBarButton
    }
    
    // MARK: - Private methods
    
    @objc private func cancelButtonClicked(_ button: UIBarButtonItem) {
        pickerParent.internalPickerWantsCancel()
    }
    
}
