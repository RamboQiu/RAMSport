//
//  RAMRunningEndView.swift
//  RAMSport
//
//  Created by rambo on 2020/2/23.
//  Copyright © 2020 rambo. All rights reserved.
//

import UIKit
import AudioToolbox

class RAMRunningEndView: UIImageView {
    
    let originWidth: CGFloat = 85.0
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("1： \(String(describing: touches.first?.force))")
        self.bounds = CGRect(x: 0.0, y: 0.0, width: originWidth, height: originWidth)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let force = touch.force
            print("2： \(force)")
            self.bounds = CGRect(x: 0.0, y: 0.0, width: originWidth * (1 + force/10), height: originWidth * (1 + force/10))
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.bounds = CGRect(x: 0.0, y: 0.0, width: originWidth, height: originWidth)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.bounds = CGRect(x: 0.0, y: 0.0, width: originWidth, height: originWidth)
//        AudioServicesPlaySystemSound(1519)
    }
    
    override func draw(_ rect: CGRect) {
        var offset: Float = 0.25 * Float(rect.width)
        offset = ceilf(Float(offset))
        let widthT = CGFloat(offset)
        let whiteRect = CGRect(origin: CGPoint(x: rect.width/2 - widthT/2, y: rect.width/2 - widthT/2), size: CGSize(width: widthT, height: widthT))
        let roundedRect = UIBezierPath(roundedRect: whiteRect, byRoundingCorners: [.allCorners], cornerRadii: CGSize(width: 2, height: 2))
        roundedRect.addClip()
        UIColor.white.setFill()
        roundedRect.fill()
    }
    
}
