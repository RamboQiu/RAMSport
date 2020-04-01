//
//  RAMRunningEndView.swift
//  RAMSport
//
//  Created by rambo on 2020/2/23.
//  Copyright © 2020 rambo. All rights reserved.
//

import UIKit
import AudioToolbox
import RxSwift
import RxCocoa

class RAMRunningEndView: UIImageView {
    
    let originWidth: CGFloat = 85.0
    @objc dynamic var ended = false
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
            timer.cancel()
            AudioServicesPlaySystemSound(1519)
            self.isUserInteractionEnabled = false
            UIView.animate(withDuration: 0.2, animations: {
                self.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            }) { (complete) in
                /// rxswift 实现的观察者模式监听改变的
                self.ended = true                
            }
        }
    }
    
}
