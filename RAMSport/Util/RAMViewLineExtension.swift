//
//  RAMViewLineExtension.swift
//  RAMSport
//
//  Created by rambo on 2020/2/20.
//  Copyright © 2020 rambo. All rights reserved.
//

import UIKit
import SnapKit

extension UIView {
    
    private struct RAMViewLineAssociatedKeys {
        static var kTopLineKey = "kTopLineKey"
        static var kBottomLineKey = "kBottomLineKey"
        static var kLeftLineKey = "kLeftLineKey"
        static var kRightLineKey = "kRightLineKey"
    }
    
    enum LinePosition: Int {
        case AtTop
        case AtBottom
        case AtLeft
        case AtRight
    }
    
    func ram_line() -> UIView {
        let image = UIImage.image(withColor: UIColor.gray)
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: RAM_SINGLE_LINE_WIDTH, height: RAM_SINGLE_LINE_WIDTH)
        return imageView
    }


    func _ram_getLine(by key: UnsafeRawPointer) -> UIView {
        var v = objc_getAssociatedObject(self, key) as? UIView
        if v == nil {
            v = ram_line()
            objc_setAssociatedObject(self, key, v, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        return v!
    }

    func ram_addLine(at position: LinePosition, left leftOffset: CGFloat, right rightOffset: CGFloat) -> UIView {
        var v = UIView()
        if position == .AtTop {
            v = _ram_getLine(by: &RAMViewLineAssociatedKeys.kBottomLineKey)
        } else if position == .AtBottom {
            v = _ram_getLine(by: &RAMViewLineAssociatedKeys.kTopLineKey);
        } else {
            return v
        }
        v.removeFromSuperview()
        
        if let cell = self as? UITableViewCell {
            cell.contentView.addSubview(v)
        } else {
            addSubview(v)
        }
        v.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(leftOffset)
            if position == .AtTop {
                make.top.equalToSuperview()
            } else if position == .AtBottom {
                make.bottom.equalToSuperview()
            }
            make.width.equalTo(RAMScreenWidth - leftOffset - rightOffset)
            make.height.equalTo(RAM_SINGLE_LINE_WIDTH)
        }
        return v
    }

    func ram_addLine(at position: LinePosition, top topOffset: CGFloat, bottom bottomOffset: CGFloat) -> UIView {
        var v = UIView()
        if position == .AtLeft {
            v = _ram_getLine(by: &RAMViewLineAssociatedKeys.kLeftLineKey)
        } else if position == .AtRight {
            v = _ram_getLine(by: &RAMViewLineAssociatedKeys.kRightLineKey);
        } else {
            return v
        }
        
        v.removeFromSuperview()
        
        if let cell = self as? UITableViewCell {
            cell.contentView.addSubview(v)
        } else {
            addSubview(v)
        }
        
        v.snp.makeConstraints { (make) in
            make.width.equalTo(RAM_SINGLE_LINE_WIDTH)
            make.top.equalToSuperview().offset(topOffset)
            make.bottom.equalToSuperview().offset(-1 * bottomOffset)
            if position == .AtLeft {
                make.left.equalToSuperview()
            } else if position == .AtRight {
                make.right.equalToSuperview()
            }
        }
        return v
    }

    // MARK: - 

    func ram_addLine(at position: LinePosition) -> UIView {
        switch position {
        case .AtBottom, .AtTop:
            return ram_addLine(at: position, left: CGFloat.leastNormalMagnitude, right: CGFloat.leastNormalMagnitude)
        case .AtLeft, .AtRight:
            return ram_addLine(at: position, top: CGFloat.leastNormalMagnitude, bottom: CGFloat.leastNormalMagnitude)
        default:
            return ram_line()
        }
    }
    
    func ram_addLine(atVertical position: LinePosition, left: CGFloat, right: CGFloat) -> UIView {
        return ram_addLine(at: position, left: left, right: right)
    }

    func ram_addLine(atHorizontal position: LinePosition, top: CGFloat, bottom: CGFloat) -> UIView {
        return ram_addLine(at: position, top: top, bottom: bottom)
    }
    
    func ram_removeLine(at position: LinePosition) {
        switch position {
        case .AtBottom:
            _ram_getLine(by: RAMViewLineAssociatedKeys.kBottomLineKey).removeFromSuperview()
        case .AtTop:
            _ram_getLine(by: RAMViewLineAssociatedKeys.kTopLineKey).removeFromSuperview()
        case .AtRight:
            _ram_getLine(by: RAMViewLineAssociatedKeys.kRightLineKey).removeFromSuperview()
        case .AtLeft:
            _ram_getLine(by: RAMViewLineAssociatedKeys.kLeftLineKey).removeFromSuperview()
        default:
            return
        }
    }
}
