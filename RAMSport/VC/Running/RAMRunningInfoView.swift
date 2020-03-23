//
//  RAMRunningInfoView.swift
//  RAMSport
//
//  Created by rambo on 2020/2/22.
//  Copyright © 2020 rambo. All rights reserved.
//

import UIKit

class RAMRunningInfoView: UIView {
    override func draw(_ rect: CGRect) {
        
        let roundedRect = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 20, height: 20))
        roundedRect.addClip()
        
        if #available(iOS 12, *) {
            if traitCollection.userInterfaceStyle == .dark {
                UIColor.black.setFill()
            } else {
                UIColor.white.setFill()
            }
        } else {
            UIColor.white.setFill()
        }
        roundedRect.fill()
    }

}
