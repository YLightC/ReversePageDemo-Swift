//
//  PageOneViewController.swift
//  ToOtherViewControllerAnimtion
//
//  Created by yaosixu on 16/6/28.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

/**  首页 */

class PageOneViewController: UIViewController {

    let button = UIButton(frame: CGRect(x: 100, y: 100, width: 150, height: 30))
    let pageAnimation = PageAnimation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "PageOne"
        automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = UIColor.blueColor()
        self.view.layer.contents = UIImage(named: "bg-1")?.CGImage
        navigationController?.delegate = self
        
        button.backgroundColor = UIColor.cyanColor()
        button.setTitle("PushPageTwo", forState: .Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        view.addSubview(button)
        button.addTarget(self, action: #selector(PageOneViewController.tapButton(_:)), forControlEvents: .TouchUpInside)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(PageOneViewController.pan(_:)))
        view.addGestureRecognizer(pan)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tapButton(button: UIButton) {
        navigationController?.pushViewController(PageTwoViewController(), animated: true)
    }
    
    /**  添加手势 */
    func pan(uiPan: UIPanGestureRecognizer) {
        
        switch uiPan.state {
        case .Began:
            pageAnimation.interactive = true
            navigationController?.pushViewController(PageTwoViewController(), animated: true)
        default:
            pageAnimation.handlePan(uiPan)
        }
        
    }
    
}

extension PageOneViewController : UINavigationControllerDelegate {
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        print("\(#function)")
        
        pageAnimation.userOperater = operation
        
        return pageAnimation
    }
    
    /** 监听手势 */
    func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        print("\(#function)")
        
        if !pageAnimation.interactive {
            return nil
        }
        
        return pageAnimation
    }
    
}
