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
    
    func applyWhiteNavigationBarStyle(_ leftBack: Bool) -> UIButton {
        if #available(iOS 13.0, *) {
            ram_statusBarStyle = .darkContent
        } else {
            ram_statusBarStyle = .default
        }
        self.navigationController?.navigationBar.ram_setBackGroundColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0))
        self.navigationController?.navigationBar.ram_shadowImage(setHidden: false)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)]
        self.navigationController?.navigationBar.ram_setDefaultBottomLine()
        if leftBack {
            return ram_addNavigationBarBackButton()
        } else {
            return ram_addNavigationBarRightButton()
        }
    }
    
    func ram_addNavigationBarBackButton() -> UIButton {
        let containerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 52, height: 44))
        let imgIconWidth = UIImage(named: "nav_back")?.size.width
        let backBtn = UIButton.init(frame: CGRect.init(x: (RAMScreenWidth == 414 ? -5 : -1), y: 0, width: 37, height: 44))
        backBtn.setImage(UIImage(named: "nav_back"), for: .normal)
        backBtn.contentEdgeInsets = UIEdgeInsets(top: 0, left: imgIconWidth! - 37, bottom: 0, right: 0)
        
        containerView.addSubview(backBtn)
        
        self.navigationItem.leftBarButtonItems = [UIBarButtonItem.init(customView: containerView)]
        backBtn.addTarget(self, action: #selector(ram_back), for: .touchUpInside)
        
        return backBtn
    }
    
    func ram_addNavigationBarRightButton() -> UIButton {
        let containerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 37, height: 44))
        let closeBtn = UIButton.init(frame: CGRect.init(x: (RAMScreenWidth == 414 ? 16 : 16), y: 0, width: 37, height: 44))
        closeBtn.setImage(UIImage(named: "close"), for: .normal)
        
        containerView.addSubview(closeBtn)
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem.init(customView: containerView)]
        closeBtn.addTarget(self, action: #selector(ram_back), for: .touchUpInside)
        
        return closeBtn
    }
    
    @objc func ram_back() {
        if self.navigationController?.viewControllers.count ?? 0 > 1 {
            self.navigationController?.popViewController(animated: true)
            return
        }
        
        if (self.presentedViewController != nil) {
            self.presentedViewController?.dismiss(animated: true, completion: {
                
            })
            return
        }
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
    
    func ram_setDefaultBottomLine() {
        self.shadowImage = UIImage.image(withColor: UIColor.gray, pixSize: CGSize(width: RAMScreenWidth, height: 1))
    }
}
