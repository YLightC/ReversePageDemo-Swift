//
//  PageTwoViewController.swift
//  ToOtherViewControllerAnimtion
//
//  Created by yaosixu on 16/6/28.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

/**  push pop */

class PageTwoViewController: UIViewController {
    
    let button = UIButton(frame: CGRect(x: 100, y: 100, width: 150, height: 30))
    let pageAnimation = PageAnimation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "PageTwo"
        view.backgroundColor = UIColor.orangeColor()
        automaticallyAdjustsScrollViewInsets = false
        self.view.layer.contents = UIImage(named: "bg-2")?.CGImage
        
        button.backgroundColor = UIColor.cyanColor()
        button.setTitle("Pop to Page One", forState: .Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.addTarget(self, action: #selector(PageTwoViewController.tapButton(_:)), forControlEvents: .TouchUpInside)
        view.addSubview(button)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(PageTwoViewController.pan(_:)))
        view.addGestureRecognizer(pan)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tapButton(popButton: UIButton) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    /**  添加手势 */
    func pan(uiPan: UIPanGestureRecognizer) {
        
        switch uiPan.state {
        case .Began:
            pageAnimation.interactive = true
            navigationController?.popViewControllerAnimated(true)
        default:
            pageAnimation.handlePan(uiPan)
        }
        
    }

    
}
