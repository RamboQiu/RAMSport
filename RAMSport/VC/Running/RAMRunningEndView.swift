//
//  RAMRunningEndView.swift
//  RAMSport
//
//  Created by rambo on 2020/2/23.
//  Copyright © 2020 rambo. All rights reserved.
//

import UIKit

class RAMRunningEndView: UIView {
    
    override func draw(_ rect: CGRect) {
        var offset: Float = 0.25 * Float(rect.width)
        offset = ceilf(Float(offset))
        let widthT = CGFloat(offset)
        let whiteRect = CGRect(origin: CGPoint(x: rect.width/2 - widthT/2, y: rect.width/2 - widthT/2), size: CGSize(width: widthT, height: widthT))
        let roundedRect = UIBezierPath(roundedRect: whiteRect, byRoundingCorners: [.allCorners], cornerRadii: CGSize(width: 2, height: 2))
        roundedRect.addClip()
        UIColor.white.setFill()
        roundedRect.fill()
    }
    
}
