//
//  RAMRunningController.swift
//  RAMSport
//
//  Created by rambo on 2020/2/17.
//  Copyright © 2020 rambo. All rights reserved.
//

import UIKit

class RAMRunningController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource, UIScrollViewDelegate {
    
    var shouldBounce: Bool = false
    private var lastPosition: CGFloat = 0.0
    private var nextIndex: Int = 0
    var currentIndex: Int = 0
    
    lazy var mapController: RAMRunningMapController = {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RAMRunningMapController")
        return vc as! RAMRunningMapController
    }()
    
    lazy var detailController: RAMRunningDetailController = {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RAMRunningDetailController")
        return vc as! RAMRunningDetailController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        
        for subview in view.subviews {
            if let scrollView = subview as? UIScrollView {
                scrollView.delegate = self
            }
        }
        
        setViewControllers([mapController], direction: .forward, animated: true, completion: nil)
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        if pendingViewControllers.first is RAMRunningDetailController {
            nextIndex = 1
        } else {
            nextIndex = 0
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if previousViewControllers.first is RAMRunningMapController {
            currentIndex = 1
        } else {
            currentIndex = 0
        }
        nextIndex = currentIndex
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentIndex
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if viewController is RAMRunningDetailController {
            return mapController
        } else {
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if viewController is RAMRunningMapController {
            return detailController
        } else {
            return nil
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        switch UIView.userInterfaceLayoutDirection(for: view.semanticContentAttribute) {
        case .leftToRight:
            if nextIndex > currentIndex {
                if scrollView.contentOffset.x < (lastPosition - (0.9 * scrollView.bounds.size.width)) {
                    currentIndex = nextIndex
                }
            } else {
                if scrollView.contentOffset.x > (lastPosition + (0.9 * scrollView.bounds.size.width)) {
                    currentIndex = nextIndex
                }
            }

            if currentIndex == 0 && scrollView.contentOffset.x < scrollView.bounds.size.width {
                scrollView.contentOffset = CGPoint(x: scrollView.bounds.size.width, y: 0)
            } else if currentIndex == 1 && scrollView.contentOffset.x > scrollView.bounds.size.width {
                scrollView.contentOffset = CGPoint(x: scrollView.bounds.size.width, y: 0)
            }
        case .rightToLeft:
            if nextIndex > currentIndex {
                if scrollView.contentOffset.x > (lastPosition + (0.9 * scrollView.bounds.size.width)) {
                    currentIndex = nextIndex
                }
            } else {
                if scrollView.contentOffset.x < (lastPosition - (0.9 * scrollView.bounds.size.width)) {
                    currentIndex = nextIndex
                }
            }

            if currentIndex == 1 && scrollView.contentOffset.x < scrollView.bounds.size.width {
                scrollView.contentOffset = CGPoint(x: scrollView.bounds.size.width, y: 0)
            } else if currentIndex == 0 && scrollView.contentOffset.x > scrollView.bounds.size.width {
                scrollView.contentOffset = CGPoint(x: scrollView.bounds.size.width, y: 0)
            }
        @unknown default:
            fatalError("unknown default")
        }

        lastPosition = scrollView.contentOffset.x
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        switch UIView.userInterfaceLayoutDirection(for: view.semanticContentAttribute) {
        case .leftToRight:
            if currentIndex == 0 && scrollView.contentOffset.x <= scrollView.bounds.size.width {
                targetContentOffset.pointee = CGPoint(x: scrollView.bounds.size.width, y: 0)
            } else if currentIndex == 1 && scrollView.contentOffset.x >= scrollView.bounds.size.width {
                targetContentOffset.pointee = CGPoint(x: scrollView.bounds.size.width, y: 0)
            }
        case .rightToLeft:
            if currentIndex == 1 && scrollView.contentOffset.x <= scrollView.bounds.size.width {
                targetContentOffset.pointee = CGPoint(x: scrollView.bounds.size.width, y: 0)
            } else if currentIndex == 0 && scrollView.contentOffset.x >= scrollView.bounds.size.width {
                targetContentOffset.pointee = CGPoint(x: scrollView.bounds.size.width, y: 0)
            }
        @unknown default:
            fatalError("unknown default")
        }
    }

}
