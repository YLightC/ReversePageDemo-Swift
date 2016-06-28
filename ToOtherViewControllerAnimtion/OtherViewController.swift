//
//  OtherViewController.swift
//  ToOtherViewControllerAnimtion
//
//  Created by yaosixu on 16/6/23.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class OtherViewController: UIViewController {

    let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 40))
    let popAnimation = PopAnimation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "ToViewController"
        view.backgroundColor = UIColor.cyanColor()
        automaticallyAdjustsScrollViewInsets = false
        button.backgroundColor = UIColor.blackColor()
        button.setTitle("back", forState: .Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.addTarget(self, action: #selector(ViewController.tapButton), forControlEvents: .TouchUpInside)
        view.addSubview(button)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tapButton() {
        self.transitioningDelegate = self
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}

extension OtherViewController :  UIViewControllerTransitioningDelegate {
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return popAnimation
        return nil
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return popAnimation
        return nil
    }
    
}
