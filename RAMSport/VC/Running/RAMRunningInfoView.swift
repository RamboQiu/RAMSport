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
        UIColor.white.setFill()
        roundedRect.fill()
    }

}
