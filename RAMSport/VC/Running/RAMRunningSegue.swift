//
//  RAMRunningSegue.swift
//  RAMSport
//
//  Created by rambo on 2020/3/23.
//  Copyright © 2020 rambo. All rights reserved.
//

import UIKit

class RAMRunningSegue: UIStoryboardSegue {
    override func perform() {
        let firstView = self.source.view
        let secondView = self.destination.view
        secondView?.alpha = 0
        
        let window = UIApplication.shared.keyWindow
        window?.insertSubview(secondView!, aboveSubview: firstView!)
        
        UIView.animate(withDuration: 1, animations: {
            firstView?.alpha = 0
            secondView?.alpha = 1
        }) { (complete) in
            self.destination.modalPresentationStyle = .fullScreen
            self.source.present(self.destination, animated: false) {
                firstView?.alpha = 1
            }
        }
    }
}
