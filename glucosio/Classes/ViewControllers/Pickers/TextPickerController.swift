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
    
//    typealias TextPickerCompletion = (_ picker: TextPickerController, _ pickedText: String) -> Void
    
//    typealias TextPickerCancellation = (_ picker: TextPickerController) -> Void
    
    weak var delegate: TextPickerControllerDelegate?
    
//    var onPickerDidFinish: TextPickerCompletion?
    
//    var onPickerDidCancel: TextPickerCancellation?
    
    fileprivate var pickedText: String {
        return textField.text ?? ""
    }
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.returnKeyType = UIReturnKeyType.send
        //textField.delegate = self
        return textField
    }()
    
    fileprivate lazy var okButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = GLUCFont.bold
        button.setTitle("Ok".localized(), for: .normal)
        button.addTarget(self, action: #selector(okButtonClicked(_:)), for: .touchUpInside)
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
    
    // MARK: - Private methods
    
    fileprivate func configureAutoLayout() {
        
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[textField(>=200)]-|", options: [], metrics: nil, views: ["textField" : textField])
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
    
    // MARK - Button actions
    
    @objc private func cancelButtonClicked(_ button: UIBarButtonItem) {
        if let _delegate = delegate {
            _delegate.textPickerControllerDidCancel(self)
//            return
        }
//        onPickerDidCancel?(self)
    }
    
    @objc private func okButtonClicked(_ button: UIBarButtonItem) {
        if let _delegate = delegate {
            _delegate.textPickerController(self, didFinishPickingText: pickedText)
//            return
        }
//        onPickerDidFinish?(self, pickedText)
    }
}
