//
//  TextPickerController.swift
//  glucosio
//
//  Created by Eugenio Baglieri on 19/09/16.
//  Copyright © 2016 Eugenio Baglieri. All rights reserved.
//

import UIKit

protocol TextPickerControllerDelegate: class {
    
    func textPickerController(_ picker: TextPickerController, didFinishPickingText text: String)
    func textPickerControllerDidCancel(_ picker: TextPickerController)
    
}

class TextPickerController: PickerController {
    
    typealias TextPickerCompletion = (_ pickedText: String) -> Void
    typealias TextPickerCancellation = () -> Void
    
    weak var delegate: TextPickerControllerDelegate?
    
    fileprivate var onPickerDidFinish: TextPickerCompletion?
    fileprivate var onPickerDidCancel: TextPickerCancellation?
    
    fileprivate var pickedText: String {
        return textField.text ?? ""
    }
    
    fileprivate(set) lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.returnKeyType = UIReturnKeyType.send
        textField.enablesReturnKeyAutomatically = true
        textField.addTarget(self, action: #selector(textFieldValueChanged(_:)), for: .editingChanged)
        return textField
    }()
    
    fileprivate lazy var okButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = GLUCFont.bold
        button.setTitle("Ok".localized, for: .normal)
        button.addTarget(self, action: #selector(okButtonClicked(_:)), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        view.addSubview(textField)
        view.addSubview(okButton)
        configureAutoLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cancelBarButton.target = self
        cancelBarButton.action = #selector(cancelButtonClicked(_:))
    }
    
    // MARK: - Public methods
    
    func setOnPickerDidFinish(_ block: TextPickerCompletion?) {
        onPickerDidFinish = block
    }
    
    func setOnPickerDidCancel(_ block: TextPickerCancellation?) {
        onPickerDidCancel = block
    }
    
    // MARK: - Private methods
    
    fileprivate func configureAutoLayout() {
        
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[textField(>=150)]-|", options: [], metrics: nil, views: ["textField" : textField])
        let centerOkButtonContstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[superview]-(<=1)-[okButton]", options: [.alignAllCenterX], metrics: nil,
                                                                        views: [
                                                                            "superview" : view,
                                                                            "okButton" : okButton
            ])
        let verticalContstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[navBar]-20-[textField]-15-[okButton(44)]-(>=20)-[bottomGuide]", options: [], metrics: nil,
                                                                  views: [
                                                                    "navBar" : navigationBar,
                                                                    "textField" : textField,
                                                                    "okButton" : okButton,
                                                                    "bottomGuide" : bottomLayoutGuide
            ])
        view.addConstraints(horizontalConstraints)
        view.addConstraints(verticalContstraints)
        view.addConstraints(centerOkButtonContstraints)
    }
    
    @objc fileprivate func textFieldValueChanged(_ sender: UITextField) {
        if let _text = sender.text {
            okButton.isEnabled = !_text.isEmpty
        } else {
            okButton.isEnabled = false
        }
    }
    
    // MARK - Button actions
    
    @objc fileprivate func cancelButtonClicked(_ button: UIBarButtonItem) {
        if let _delegate = delegate {
            _delegate.textPickerControllerDidCancel(self)
            return
        }
        onPickerDidCancel?()
    }
    
    @objc fileprivate func okButtonClicked(_ button: UIBarButtonItem) {
        if let _delegate = delegate {
            _delegate.textPickerController(self, didFinishPickingText: pickedText)
            return
        }
        onPickerDidFinish?(pickedText)
    }
}
