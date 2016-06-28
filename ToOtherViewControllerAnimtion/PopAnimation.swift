//
//  PopAnimation.swift
//  ToOtherViewControllerAnimtion
//
//  Created by yaosixu on 16/6/23.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class PopAnimation: NSObject,UIViewControllerAnimatedTransitioning {

    var isTo = true
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 1
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        if isTo {
            presentAnimation(transitionContext)
        } else {
            dismissAnimation(transitionContext)
        }
        
    }
    
    // present动画
    func presentAnimation(transitionContext: UIViewControllerContextTransitioning) {
        let formView = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let toView = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        
        // 对formView进行截图
        let tempView = formView?.view.snapshotViewAfterScreenUpdates(false)
        tempView?.frame = (formView?.view.frame)!
        
        formView?.view.hidden = true
        
        let containerView = transitionContext.containerView()
        containerView?.addSubview(tempView!)
        containerView?.addSubview((toView?.view)!)
        // 设置toView的初始位置
        toView!.view.frame = CGRect(x: 0, y: containerView!.bounds.height, width: containerView!.bounds.width, height: 400)
        
        UIView.animateWithDuration(1, delay: 0.0, usingSpringWithDamping: 0.55, initialSpringVelocity: 1.0 / 0.55, options: [], animations: {
                //平移
                toView!.view.transform = CGAffineTransformMakeTranslation(0, -400)
                tempView?.transform = CGAffineTransformMakeScale(0.85, 0.85)
            }, completion: { _ in
                transitionContext.completeTransition(true)
        })
        
    }
    
    //dismiss动画
    func dismissAnimation(transitionContext: UIViewControllerContextTransitioning) {
        let formView = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let toView = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        
        let tempView = transitionContext.containerView()?.subviews[0]
        
        UIView.animateWithDuration(1, animations: {
            formView?.view.transform = CGAffineTransformIdentity
            tempView!.transform = CGAffineTransformIdentity
            }, completion: { _ in
             transitionContext.completeTransition(true)
            toView?.view.hidden = false
            tempView?.removeFromSuperview()
        })
    }
    
}
