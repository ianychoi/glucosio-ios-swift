//
//  AlertAnimationPresentationController.swift
//  SwipeAndCall
//
//  Created by Eugenio Baglieri on 11/08/15.
//  Copyright © 2015 Eugenio Baglieri. All rights reserved.
//

import UIKit



class PopupTransitionManager: NSObject, UIViewControllerAnimatedTransitioning {
    
    var isPresenting: Bool = false
    let duration: TimeInterval = 0.3
    
    //MARK: - UIViewControllerAnimatedTransitioning
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresenting {
            animatePresentation(using: transitionContext)
        } else {
            animateDismissal(using: transitionContext)
        }
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    // MARK: - Private Methods
    
    private func animatePresentation(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let presentedController = transitionContext.viewController(forKey: .to),
            let presentedControllerView = transitionContext.view(forKey: .to) else {
                assertionFailure("No presented controller found")
                return
        }
        
        let containerView = transitionContext.containerView
        
        presentedControllerView.frame = transitionContext.finalFrame(for: presentedController)
        presentedControllerView.alpha = 0
        
        containerView.addSubview(presentedControllerView)
        
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.2, options: .allowUserInteraction,
                       animations: {
                        presentedControllerView.alpha = 1
            }, completion: { completed in
                if completed {
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                }
                
        })
        
    }
    
    
    private func animateDismissal(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let presentedControllerView = transitionContext.view(forKey: .from) else {
            assertionFailure("No presented controller view found")
            return
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: .allowUserInteraction, animations: {
            presentedControllerView.alpha = 0.0
            }, completion: { completed in
                if completed {
                    presentedControllerView.removeFromSuperview()
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                }
        })
    }
}

extension PopupTransitionManager: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return PopupPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = false
        return self
    }
}
