//
//  AlertPresentationController.swift
//  SwipeAndCall
//
//  Created by Eugenio Baglieri on 09/08/15.
//  Copyright © 2015 Eugenio Baglieri. All rights reserved.
//

import UIKit

class PopupPresentationController: UIPresentationController {

    fileprivate let cornerRadius: CGFloat = 4.0
    
    fileprivate let dimmingView = UIView()
    

    /// This view is placed behind the presentedCiewController view, as its sibling in the containerView hierarchy
    fileprivate lazy var shadowView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.clear
        v.layer.backgroundColor = UIColor.black.withAlphaComponent(0.7).cgColor
        v.layer.cornerRadius = self.cornerRadius
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowOpacity = 0.8
        v.layer.shadowRadius = 8
        v.layer.shadowOffset = CGSize(width: 3, height: 3)
        return v
    }()
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(dimmingViewTapped(sender:)) )
        dimmingView.addGestureRecognizer(tapRecognizer)
    }
    
    override func presentationTransitionWillBegin() {
        
        let presentedViewLayer = presentedViewController.view.layer
        presentedViewLayer.cornerRadius = cornerRadius
        presentedViewLayer.masksToBounds = true
        
        dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        dimmingView.alpha = 0.0
        
        containerView?.addSubview(dimmingView)
        containerView?.insertSubview(shadowView, belowSubview: presentedViewController.view)
        
        presentingViewController.transitionCoordinator?.animate(alongsideTransition: { context in
            self.dimmingView.alpha  = 1.0
            }, completion: nil)
            
    }
    
    override func dismissalTransitionWillBegin() {
        shadowView.alpha = 0.0
        presentingViewController.transitionCoordinator?.animate(alongsideTransition: { context in
            self.dimmingView.alpha  = 0.0
            }, completion: nil)
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            shadowView.removeFromSuperview()
            dimmingView.removeFromSuperview()
        }
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        return calculateFrameOfContentView()
    }
    
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        dimmingView.frame = containerView!.bounds
        shadowView.frame = presentedViewController.view.frame
        //shadowView.layer.shadowPath = UIBezierPath(roundedRect: presentedViewController.view.bounds, cornerRadius: cornerRadius).cgPath
    }
    
    // MARK: - Private Methods
    
    //FIXME: Handle rotation with UIAdaptivePResentationControllerDelegate
    private func calculateFrameOfContentView() -> CGRect {
        
        guard let containerView = containerView else {
            return CGRect.zero
        }
        
        let margin = UIEdgeInsets(top: 60, left: 45, bottom: 60, right: 45)
        let bounds = containerView.bounds
        let maxPopupSize = CGSize(width: bounds.width - margin.left - margin.right, height: bounds.height - margin.top - margin.bottom)
        var minimumPresentedContentSize = presentedViewController.view.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        
        minimumPresentedContentSize.width = maxPopupSize.width
        
        if minimumPresentedContentSize.height > maxPopupSize.height {
            minimumPresentedContentSize.height = maxPopupSize.height
        }
        
        let frame = CGRect(x: (bounds.width - minimumPresentedContentSize.width) / 2, y: (bounds.height - minimumPresentedContentSize.height) / 2, width: minimumPresentedContentSize.width, height: minimumPresentedContentSize.height)
        
        return frame
    }
    
    @objc private func dimmingViewTapped(sender: UITapGestureRecognizer) {
        presentedViewController.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
