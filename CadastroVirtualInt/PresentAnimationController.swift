//
//  PresentAnimationController.swift
//  CadastroVirtualInt
//
//  Created by Alan Fritsch on 26/05/19.
//  Copyright © 2019 Alan Fritsch. All rights reserved.
//

import UIKit

class PresentAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let finalFrameForViewController = transitionContext.finalFrame(for: toViewController)
        toViewController.view.frame = finalFrameForViewController.offsetBy(dx: 0, dy: UIScreen.main.bounds.height)
        
        transitionContext.containerView.addSubview(toViewController.view)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.1, options: .curveEaseIn, animations: {
            fromViewController.view.alpha = 0.5
            toViewController.view.frame = finalFrameForViewController
        }, completion: {
            finished in
            transitionContext.completeTransition(true)
            fromViewController.view.alpha = 1.0
        })
    }
    
}
