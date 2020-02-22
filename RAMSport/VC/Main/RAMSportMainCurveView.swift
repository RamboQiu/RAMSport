//
//  RAMSportMainCurveView.swift
//  RAMSport
//
//  Created by rambo on 2020/2/21.
//  Copyright © 2020 rambo. All rights reserved.
//

import UIKit

//@IBDesignable
class RAMSportMainCurveView: UIView {
    
//    @IBInspectable
    var isCurve = true
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    var title: String = "" {
        didSet {
            let mutString = NSMutableAttributedString()
            let arr = title.split(separator: " ")
            mutString.append(NSAttributedString(string: String(arr[0]), attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)]))
            if arr.count > 1 {
                mutString.append(NSAttributedString(string: " " + String(arr[1]), attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)]))
            }
            titleLabel.attributedText = mutString
        }
    }
    
    var desc: String = "" {
        didSet {
            descLabel.text = desc
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        let path = UIBezierPath()
        let offset = 50.0
        var startPoint = CGPoint(x: 0, y: 7 + offset)
        path.move(to: startPoint)
        let pointArray = [10.0, 20.0, 0.0, 30.0, 10.0, 15.0, 40.0]
        let xInstance = 20.0
        
        for i in 0..<pointArray.count {
            let endPoint = CGPoint(x: xInstance * Double(i+1), y: offset+pointArray[i])
            let centerX = (startPoint.x + endPoint.x)/2
            let crl1 = CGPoint(x: centerX, y: startPoint.y)
            let crl2 = CGPoint(x: centerX, y: endPoint.y)
            if (isCurve) {
                path.addCurve(to: endPoint, controlPoint1: crl1, controlPoint2: crl2)
                startPoint = endPoint;
            } else {
                path.addLine(to: endPoint)

            }
        }
        UIColor.black.setStroke()
        context.setLineWidth(2)
        context.addPath(path.cgPath)
        context.strokePath()
    }

}
