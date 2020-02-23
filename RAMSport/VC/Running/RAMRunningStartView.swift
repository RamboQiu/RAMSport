//
//  RAMRunningStartView.swift
//  RAMSport
//
//  Created by rambo on 2020/2/23.
//  Copyright © 2020 rambo. All rights reserved.
//

import UIKit

class RAMRunningStartView: UIButton {

    
    override func draw(_ rect: CGRect) {
    
        var offset: Float = 0.25 * Float(rect.width)
        offset = ceilf(Float(offset))
        let widthT = CGFloat(offset)
        
        let path = UIBezierPath()
        var startPoint = CGPoint(x: rect.width/2 - widthT/2 + 2, y: rect.width/2 - widthT/2)
        let endPoint = startPoint
        
        path.move(to: startPoint)
        startPoint = CGPoint(x: rect.width/2 + widthT/2 + 2, y: rect.width/2)
        path.addLine(to: startPoint)
        
        startPoint = CGPoint(x: rect.width/2 - widthT/2 + 2, y: rect.width/2 + widthT/2)
        path.addLine(to: startPoint)
        path.addLine(to: endPoint)
        
        UIColor.white.setStroke()
        UIColor.white.setFill()
        path.lineWidth = 6
        path.lineJoinStyle = .round
        path.lineCapStyle = .round
        path.stroke()
        path.fill()
        
    }

}
