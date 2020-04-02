//
//  RAMNavigationTransitionDelegate.swift
//  RAMSport
//
//  Created by rambo on 2020/4/2.
//  Copyright © 2020 rambo. All rights reserved.
//

import UIKit

class RAMNavigationTransitionDelegate: NSObject, UINavigationControllerDelegate {
    
    let alphaPushAnimator = RAMAlphaPushAnimator()

    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == UINavigationController.Operation.push {
            if toVC is RAMRunningMapController {
                return alphaPushAnimator
            }
            if fromVC is RAMRunningMapController, toVC is RAMDetailController {
                return alphaPushAnimator
            }
        } else if operation == UINavigationController.Operation.pop {
            
        }
        return nil
    }
    
    
    
}
