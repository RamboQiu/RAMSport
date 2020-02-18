//
//  UIViewFrameExtension.swift
//  RAMSport
//
//  Created by rambo on 2020/2/17.
//  Copyright © 2020 rambo. All rights reserved.
//

import UIKit

extension UIView {
    var x: CGFloat {
        get {
            frame.minX
        }
        set {
            var newFrame = frame
            newFrame.origin.x = newValue
            frame = newFrame
        }
    }
    var y: CGFloat {
        get {
            frame.minY
        }
        set {
            var newFrame = frame
            newFrame.origin.y = newValue
            frame = newFrame
        }
    }
    var width: CGFloat {
        get {
            frame.width
        }
        set {
            var newFrame = frame
            newFrame.size.width = newValue
            frame = newFrame
        }
    }
    var height: CGFloat {
        get {
            frame.height
        }
        set {
            var newFrame = frame
            newFrame.size.height = newValue
            frame = newFrame
        }
    }
    var bottom: CGFloat {
        get {
            frame.maxY
        }
        set {
            var newFrame = frame
            newFrame.origin.y = newValue - newFrame.size.height
            frame = newFrame
        }
    }
    var tail: CGFloat {
        get {
            frame.maxX
        }
        set {
            var newFrame = frame
            newFrame.origin.x = newValue - newFrame.size.width
            frame = newFrame
        }
    }
    var midX: CGFloat {
        get {
            frame.midX
        }
        set {
            var newFrame = frame
            newFrame.origin.x = newValue - newFrame.size.width / 2
            frame = newFrame
        }
    }
    var midY: CGFloat {
        get {
            frame.midY
        }
        set {
            var newFrame = frame
            newFrame.origin.y = newValue - newFrame.size.height / 2
            frame = newFrame
        }
    }
    
    func ceilFrameXY() {
        self.x = ceil(self.x);
        self.y = ceil(self.y);
    }
}
