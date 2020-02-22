//
//  RAMSportMainCenterCircleView.swift
//  RAMSport
//
//  Created by rambo on 2020/2/20.
//  Copyright © 2020 rambo. All rights reserved.
//

import UIKit

//@IBDesignable
class RAMSportMainCenterCircleView: UIView {
    
//    @IBInspectable
    var angle = 0.0
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    override func draw(_ rect: CGRect) {
        //获取绘图上下文
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
         
        //使用rgb颜色空间
        let colorSpace = CGColorSpaceCreateDeviceRGB()
//        #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        //颜色数组（这里使用三组颜色作为渐变）fc6820
        /// dark 0 0 0 1
        /// light 1 1 1 1
        let compoents:[CGFloat] = [1, 1, 1, 1,
                                   0, 0, 0, 0]
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
        
        context.addArc(center: CGPoint(x: width/2, y: height/2), radius: width/2 - 3, startAngle: -.pi / 2, endAngle: CGFloat(angle - .pi / 2), clockwise: false)
        UIColor.black.setStroke()
        context.setLineWidth(6.0)
        context.setLineCap(.round)
        context.drawPath(using: .stroke)
    }

}
