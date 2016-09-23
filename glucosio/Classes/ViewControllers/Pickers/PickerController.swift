//
//  PickerController.swift
//  glucosio
//
//  Created by Eugenio Baglieri on 19/09/16.
//  Copyright © 2016 Eugenio Baglieri. All rights reserved.
//

import UIKit

class PickerController: UIViewController {
    
    let popupTransitionManager = PopupTransitionManager()
    
    let navigationBar: UINavigationBar = {
        let navBar = UINavigationBar()
        navBar.translatesAutoresizingMaskIntoConstraints = false
        return navBar
    }()
    
    fileprivate(set) lazy var doneBarButton: GLUCBarButtonItem = {
        let button = GLUCBarButtonItem(systemItem: .done, target: nil, action: nil)
        return button
    }()
    
    fileprivate(set) lazy var cancelBarButton: GLUCBarButtonItem = {
        let button = GLUCBarButtonItem(systemItem: .cancel, target: nil, action: nil)
        return button
    }()
    
    //MARK: - Initialization
    
    init() {
        super.init(nibName: nil, bundle: nil)
        navigationBar.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        view.addSubview(navigationBar)
        view.backgroundColor = UIColor.white
        configureAutoLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = cancelBarButton
        navigationBar.items = [navigationItem]
    }
    
    
    // MARK: - Private methods
    
    fileprivate func configureAutoLayout() {
        
        //navigation bar should never get shrinked
        navigationBar.setContentCompressionResistancePriority(1000, for: .vertical)
        
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[navBar]|", options: [], metrics: nil, views: ["navBar" : navigationBar])
        let verticalContstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[navBar]", options: [], metrics: nil,
                                                                  views: ["navBar" : navigationBar])
        view.addConstraints(horizontalConstraints)
        view.addConstraints(verticalContstraints)
        
    }
    
    // MARK: - Public methods
    
    func setPopupPresentation() {
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = popupTransitionManager
    }

}

extension PickerController: UINavigationBarDelegate {

    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .top
    }
    
}
