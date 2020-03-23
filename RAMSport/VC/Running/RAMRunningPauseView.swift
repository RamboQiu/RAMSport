//
//  RAMRunningPauseView.swift
//  RAMSport
//
//  Created by rambo on 2020/2/23.
//  Copyright © 2020 rambo. All rights reserved.
//

import UIKit

class RAMRunningPauseView: UIButton {

    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        var offset: Float = 0.37 * Float(rect.width)
        offset = ceilf(Float(offset))
        let path = UIBezierPath()
        var startPoint = CGPoint(x: rect.width / 2 - 8, y: CGFloat(offset))
        
        path.move(to: startPoint)
        var endPoint = CGPoint(x: rect.width / 2 - 8, y: rect.height - CGFloat(offset))
        path.addLine(to: endPoint)
        
        startPoint = CGPoint(x: rect.width / 2 + 8, y: CGFloat(offset))
        path.move(to: startPoint)
        endPoint = CGPoint(x: rect.width / 2 + 8, y: rect.height - CGFloat(offset))
        path.addLine(to: endPoint)
        
        if #available(iOS 12, *) {
            if traitCollection.userInterfaceStyle == .dark {
                UIColor.black.setStroke()
            } else {
                UIColor.white.setStroke()
            }
        } else {
            UIColor.white.setStroke()
        }
        context.setLineWidth(6)
        context.addPath(path.cgPath)
        context.setLineCap(.round)
        context.strokePath()
        
    }

}
