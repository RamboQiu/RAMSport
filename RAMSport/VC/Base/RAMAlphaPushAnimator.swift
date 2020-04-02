//
//  RAMAlphaPushAnimator.swift
//  RAMSport
//
//  Created by rambo on 2020/4/2.
//  Copyright © 2020 rambo. All rights reserved.
//

import UIKit

class RAMAlphaPushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let destination = transitionContext.view(forKey: UITransitionContextViewKey.to)
        let source = transitionContext.view(forKey: UITransitionContextViewKey.from)
        transitionContext.containerView.addSubview(destination!)
        transitionContext.containerView.addSubview(source!)
        destination?.alpha = 0
        UIView.animate(withDuration: 1, animations: {
            destination?.alpha = 1
            source?.alpha = 0
        }) { (complete) in
            source?.alpha = 1
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    

}
