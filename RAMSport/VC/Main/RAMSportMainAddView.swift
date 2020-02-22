//
//  RAMSportMainAddView.swift
//  RAMSport
//
//  Created by rambo on 2020/2/21.
//  Copyright © 2020 rambo. All rights reserved.
//

import UIKit

class RAMSportMainAddView: UIView {
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        //使用rgb颜色空间
        let colorSpace = CGColorSpaceCreateDeviceRGB()
//        #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        //颜色数组（这里使用三组颜色作为渐变）fc6820
        /// dark 0 0 0 1
        /// light 1 1 1 1
        
//        #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        
        let compoents:[CGFloat] = [0.3098039329, 0.01568627544, 0.1294117719, 1,
                                   0.5725490451, 0, 0.2313725501, 1]
        //没组颜色所在位置（范围0~1)
        let locations:[CGFloat] = [0,1]
        //生成渐变色（count参数表示渐变个数）
        let gradient = CGGradient(colorSpace: colorSpace, colorComponents: compoents,
                                  locations: locations, count: locations.count)!
         
        //渐变开始位置
        let start = CGPoint(x: self.bounds.minX, y: self.bounds.minY)
        //渐变结束位置
        let end = CGPoint(x: self.bounds.minX, y: self.bounds.maxY)
        //绘制渐变
        context.drawLinearGradient(gradient, start: start, end: end,
                                   options: .drawsBeforeStartLocation)
        
        let offset: CGFloat = 20.0
        let path = UIBezierPath()
        var startPoint = CGPoint(x: rect.width / 2, y: offset)
        
        path.move(to: startPoint)
        var endPoint = CGPoint(x: rect.width / 2, y: rect.height - offset)
        path.addLine(to: endPoint)
        
        startPoint = CGPoint(x: offset, y: rect.height / 2)
        path.move(to: startPoint)
        endPoint = CGPoint(x: rect.width - offset, y: rect.height / 2)
        path.addLine(to: endPoint)
        
        UIColor.white.setStroke()
        context.setLineWidth(2)
        context.addPath(path.cgPath)
        context.setLineCap(.round)
        context.strokePath()
    }

}
