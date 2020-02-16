//
//  RAMNavigator.swift
//  RAMSport
//
//  Created by rambo on 2020/2/16.
//  Copyright © 2020 rambo. All rights reserved.
//

import UIKit

extension UIViewController {
    
    private struct RAMNavigatorAssociatedKeys {
        static var ram_statusBarStyleKey = "ram_statusBarStyleKey"
    }
    
    var ram_statusBarStyle: UIStatusBarStyle {
        get {
            return objc_getAssociatedObject(self, &RAMNavigatorAssociatedKeys.ram_statusBarStyleKey) as! UIStatusBarStyle
        }
        set {
            objc_setAssociatedObject(self, &RAMNavigatorAssociatedKeys.ram_statusBarStyleKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func applyClearNavigationBarStyle() {
        if #available(iOS 13.0, *) {
            ram_statusBarStyle = .darkContent
        } else {
            ram_statusBarStyle = .default
        }
        
        self.navigationController?.navigationBar.ram_setBackGroundColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0))
        self.navigationController?.navigationBar.ram_shadowImage(setHidden: true)
    }
}

extension UINavigationBar {
    
    var ram_backGroundView: UIView {
        return self.subviews.first!
    }
    
    func ram_setBackGroundColor(_ color: UIColor) {
       //这里必须设置为透明的图，设置为nil也不起作用
        setBackgroundImage(UIImage.image(withColor: UIColor.init(red: color.red, green: color.green, blue: color.blue, alpha: color.alpha * 0.99)), for: .default)
       
       let bgView = ram_backGroundView
       bgView.backgroundColor = color
    }
    
    func ram_shadowImage(setHidden hidden: Bool) {
        let bgView = ram_backGroundView
        for lineView in bgView.subviews {
            if lineView.frame.height <= 1 {
                lineView.isHidden = hidden;
            }
        }
    }
}
