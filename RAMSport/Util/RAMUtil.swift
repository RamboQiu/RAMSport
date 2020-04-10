//
//  RAMUtil.swift
//  RAMSport
//
//  Created by rambo on 2020/2/16.
//  Copyright © 2020 rambo. All rights reserved.
//

import UIKit

extension UIImage {

    class func image(withColor color:UIColor) -> UIImage {
        return image(withColor: color, andSize: CGSize(width: 1, height: 1))
    }
    
    class func image(withColor color:UIColor, andSize size:CGSize) -> UIImage {
        let scale = UIScreen.main.scale
        let width = size.width
        let height = size.height
        let fillRect = CGRect(x: 0, y: 0, width: width, height: height)
        
        UIGraphicsBeginImageContextWithOptions(fillRect.size, false, scale)
        let context = UIGraphicsGetCurrentContext()!
        
        context.setFillColor(color.cgColor)
        context.fill(fillRect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return image;
    }
    
    class func image(withColor color:UIColor, pixSize size:CGSize) -> UIImage {
        let scale = UIScreen.main.scale
        let pixSizeW = size.width / scale
        let pixSizeH = size.height / scale
        let fillRect = CGRect(x: 0, y: 0, width: pixSizeW, height: pixSizeH)
        
        UIGraphicsBeginImageContextWithOptions(fillRect.size, false, scale)
        let context = UIGraphicsGetCurrentContext()!
        
        context.setFillColor(color.cgColor)
        context.fill(fillRect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext();
        
        return image;
    }
}

extension UIColor {
    
    private func getRGBAComponents(atIndex index: Int) -> CGFloat {
        
        let model = self.cgColor.colorSpace?.model
        let components = self.cgColor.components!
        switch (model) {
        case .monochrome:
            if index < 3 {
                return components[0]
            } else {
                return components[1]
            }
        case .rgb: return components[index]
        default:
            if index < 3 {
                return 0.0
            } else {
                return 1.0
            }
        }
    }
    
    var red: CGFloat {
        return getRGBAComponents(atIndex: 0)
    }
    
    var green: CGFloat {
        return getRGBAComponents(atIndex: 1)
    }
    
    var blue: CGFloat {
        return getRGBAComponents(atIndex: 2)
    }
    
    var alpha: CGFloat {
        return self.cgColor.alpha
    }
}

extension Float {

    /// 返回末尾不带0的小数
    var clearString: String {
        if fmodf(Float(self), 1) == 0 {
            return String(format: "%.0f", self)
        } else if fmodf(Float(self * 10), 1) == 0 {
            return String(format: "%.1f", self)
        } else {
            return String(format: "%.2f", self)
        }
    }
}
