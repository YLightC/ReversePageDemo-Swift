//
//  ViewController.swift
//  ToOtherViewControllerAnimtion
//
//  Created by yaosixu on 16/6/23.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 40))
    let popAnimation = PopAnimation()
    
    override func viewDidLoad() {
        UIApplication.sharedApplication().keyWindow?.backgroundColor = UIColor.whiteColor()
        super.viewDidLoad()
        title = "formViewController"
        automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = UIColor.whiteColor()
        button.backgroundColor = UIColor.blackColor()
        button.setTitle("toOther", forState: .Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.addTarget(self, action: #selector(ViewController.tapButton), forControlEvents: .TouchUpInside)
        view.addSubview(button)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func tapButton() {
        let nvc = UINavigationController(rootViewController: OtherViewController())
        nvc.transitioningDelegate = self
        presentViewController(nvc, animated: true, completion: nil)
    }

}

extension ViewController : UIViewControllerTransitioningDelegate {
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        popAnimation.isTo = true
        return popAnimation
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        popAnimation.isTo = false
        return popAnimation
    }
    
}

