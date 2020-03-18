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
    var ended = false
    var millCount = 0
    lazy var timer: DispatchSourceTimer = {
        let t = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
        t.schedule(deadline: .now(), repeating: .milliseconds(100))
        t.setEventHandler {
            self.millCount += 1
            if self.millCount > 10 {
                DispatchQueue.main.async {
                    self.endTouch()
                }
            }
        }
        return t
    }()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        timer.resume()
        self.bounds = CGRect(x: 0.0, y: 0.0, width: originWidth, height: originWidth)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, !ended {
            let force = touch.force
            self.bounds = CGRect(x: 0.0, y: 0.0, width: originWidth * (1 + force/10), height: originWidth * (1 + force/10))
            if force > 6 {
                endTouch()
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !ended {
            suspend()
            self.bounds = CGRect(x: 0.0, y: 0.0, width: originWidth, height: originWidth)
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        suspend()
        self.bounds = CGRect(x: 0.0, y: 0.0, width: originWidth, height: originWidth)
        
    }
    
    func suspend() {
        timer.suspend()
        millCount = 0
    }
    
    func endTouch() {
        if !ended {
            ended = true
            timer.cancel()
            AudioServicesPlaySystemSound(1519)
            self.isUserInteractionEnabled = false
            UIView.animate(withDuration: 0.2) {
                self.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            }
        }
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
