//
//  PageAnimation.swift
//  ToOtherViewControllerAnimtion
//
//  Created by yaosixu on 16/6/28.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

/**  翻页动画 */

class PageAnimation: UIPercentDrivenInteractiveTransition,UIViewControllerAnimatedTransitioning {
    
    var userOperater : UINavigationControllerOperation = .Push
    var animationDuration : NSTimeInterval = 3
    var interactive = false
    weak var storedContext: UIViewControllerContextTransitioning?
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return animationDuration
    }
    
    func handlePan(recognizer: UIPanGestureRecognizer) {
        print("\(#function)")
        let translation = recognizer.translationInView(recognizer.view!.superview!)
        var progress: CGFloat = abs(translation.x / 200)
        progress = min(max(progress,0.01), 0.99)
        
        switch recognizer.state {
        case .Changed :
            updateInteractiveTransition(progress)
        case .Cancelled, .Ended :
            let transitionLayer = storedContext?.containerView()?.layer
            transitionLayer?.beginTime = CACurrentMediaTime()
            
            if progress < 0.5 {
                completionSpeed = -1.0
                cancelInteractiveTransition()
            } else {
                completionSpeed = 1.0
                finishInteractiveTransition()
            }
            interactive = false
        default:
            break
        }
        
    }

    
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        print("\(#function)")
        
        guard let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) else {
            return
        }
        
        guard let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) else {
            return
        }
        
        if userOperater == .Push {
            pushAnimation(fromVC, toVC: toVC,transitionContext: transitionContext)
        } else if userOperater == .Pop {
            popAnimation(fromVC, toVC: toVC,transitionContext: transitionContext)
        }
    }
    
    /** push Animation */
    func pushAnimation(fromVC: UIViewController, toVC: UIViewController,transitionContext: UIViewControllerContextTransitioning) {
        print("\(#function)")
        
        transitionContext.containerView()?.insertSubview(toVC.view, belowSubview: fromVC.view)
        fromVC.view.layer.anchorPoint = CGPointMake(0, 0.5)
        fromVC.view.frame = fromVC.view.bounds
        var rotate = CATransform3DIdentity
        rotate.m34 = -4 / 5000
        
        UIView.animateWithDuration(animationDuration, animations: {
                fromVC.view.layer.transform = CATransform3DRotate(rotate, CGFloat(-M_PI_2), 0, 1, 0)
            }, completion: { _ in
                if transitionContext.transitionWasCancelled() {
                    print("Push 失败")
                    fromVC.view.layer.removeAllAnimations()
                    fromVC.view.layer.transform = CATransform3DIdentity
                    transitionContext.completeTransition(false)
                } else {
                    fromVC.view.removeFromSuperview()
                    transitionContext.completeTransition(true)
                }
                
        })
    }
    
    /** pop Animation */
    func popAnimation(fromVC: UIViewController, toVC: UIViewController,transitionContext: UIViewControllerContextTransitioning) {
        print("\(#function)")
        
        transitionContext.containerView()?.addSubview(toVC.view)
        transitionContext.containerView()?.bringSubviewToFront(toVC.view)
        var rotate = CATransform3DIdentity
        rotate.m34 = 4 / 5000
        
        UIView.animateWithDuration(animationDuration, animations: {
                toVC.view.layer.transform =  CATransform3DIdentity
                fromVC.view.alpha = 0.4
            }, completion: { _ in
                if transitionContext.transitionWasCancelled() {
                    print("Pop 失败")
                    fromVC.view.layer.removeAllAnimations()
                    toVC.view.layer.removeAllAnimations()
                    transitionContext.completeTransition(false)
                } else {
                    fromVC.view.removeFromSuperview()
                    toVC.view.layer.anchorPoint = CGPointMake(0.5, 0.5)
                    toVC.view.frame = toVC.view.bounds
                    transitionContext.completeTransition(true)
                }
        })
    }
    
}
