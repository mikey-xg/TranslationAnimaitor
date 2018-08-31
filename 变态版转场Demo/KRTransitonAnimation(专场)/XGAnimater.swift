//
//  XGAnimater.swift
//  变态版转场Demo
//
//  Created by best su on 2018/5/31.
//  Copyright © 2018年 bestsu. All rights reserved.
//

import UIKit

///屏幕尺寸
let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

enum StartAnimitationStyles {
    /// 缩放出现
    case scales
    /// 弹性出现
    case spring
    ///  金币弹出样式
    case glod
    /// 不含电池条的样式
    case nonePower
    /// 右侧向左侧弹出
    case rightToLeft
    /// 默认present样式(向上弹出)
    case `default`
}

enum EndAnimitationStyles {
     /// 缩放消失动画(缩小)
    case animator
    /// 无许动画
    case noneAnimator
     ///结束向右侧移动
    case rightAnimator
    ///向上弹出
    case up
    /// 表示默认present的dismiss的样式(向下弹出消失)
    case `default`
}

class XGAnimater: NSObject {
//    MARK: 转场的view的frame
    var presentedFrame : CGRect = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
    //    MARK: 转场的view的背景颜色
    var presentedBgColor: UIColor = UIColor.clear
//    MARK: 底部带背景颜色的view的frame
    var coverFrame: CGRect = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
//    MARK:给coverView添加背景颜色
    var coverViewBgColor: UIColor = UIColor(white: 0.1, alpha: 0.5)
    //    MARK:
    var isPresented: Bool = false
    ///弹出的动效样式 (默认和present样式相同)
    var presentAnimatorStyle: StartAnimitationStyles = .default
    ///消失的动效样式 (默认和present消失的样式相同)
    var presentAnimatorEndStyle: EndAnimitationStyles = .default
    /// 设置 开始 动画时长(默认0.3)
    var animatinoDuration: Double = 0.3
    /// 设置 结束 动画时长(默认0.3)
    var animationEndDuration: Double = 0.3
}


extension XGAnimater : UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        let prensentVc = XGPresentationVc.init(presentedViewController: presented, presenting: presenting)
        prensentVc.presentedFrame = presentedFrame
        prensentVc.presentedBgColor = presentedBgColor
        prensentVc.coverFrame = coverFrame
        prensentVc.coverViewBgColor = coverViewBgColor
        return prensentVc
        
    }
    
    //目的：自定义弹出动画
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = true
        return self
    }
    
    //目的：自定义消失出动画
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = false
        return self
    }
    
}

//MARK: - 弹出和消失的动画方法
extension XGAnimater : UIViewControllerAnimatedTransitioning {
    //设置动画执行的时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    //获取转场动画的上下文
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        isPresented ? animationForPresentedView(transitionContext) : animationForDismissedView(transitionContext)
    }
    
    ///自定义弹出动画
    fileprivate func animationForPresentedView(_ transitionContext: UIViewControllerContextTransitioning) {
        //获取弹出的View
        let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        //将弹出的View加到containerView中
        transitionContext.containerView.addSubview(presentedView)
        transitionContext.containerView.alpha = 0
        // MARK:  执行动画
        switch self.presentAnimatorStyle {
            
        case .scales:
            //缩放效果需要打开此代码
            presentedView.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
            UIView.animate(withDuration: animatinoDuration, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                transitionContext.containerView.alpha = 1
                presentedView.transform = CGAffineTransform.identity
            }, completion: { (_) in
                transitionContext.completeTransition(true)
            })
            
        case .spring:
            presentedView.frame.origin.y = -100 //* currentHeight
            UIView.animate(withDuration: animatinoDuration, delay: 0, usingSpringWithDamping: 0.55, initialSpringVelocity: 0, options: .curveLinear, animations: {
                transitionContext.containerView.alpha = 1
                presentedView.frame.origin.y = 200 //* currentHeight
            }) { (_) in
                //必须告诉转场上下文你已经完成动画
                transitionContext.completeTransition(true)
            }
            
        case .glod:
            presentedView.frame.origin.y = screenHeight
            presentedView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            UIView.animate(withDuration: animatinoDuration, animations: {
                transitionContext.containerView.alpha = 1
                presentedView.frame.origin.y = 200 //* currentHeight
            }, completion: { (_) in
                transitionContext.completeTransition(true)
            })
            
        case .nonePower:
            presentedView.frame.origin.x = screenWidth
            presentedView.frame.origin.y = screenHeight
            UIView.animate(withDuration: animatinoDuration, animations: {
                transitionContext.containerView.alpha = 1
                presentedView.frame.origin.x = 0
            }, completion: { (_) in
                transitionContext.completeTransition(true)
            })
            
        case .rightToLeft:
            presentedView.frame.origin.x = screenWidth
            presentedView.frame.origin.y = screenHeight
            UIView.animate(withDuration: animatinoDuration, animations: {
                transitionContext.containerView.alpha = 1
                presentedView.frame.origin.x = 0
            }, completion: { (_) in
                transitionContext.completeTransition(true)
            })
        case .default:
            presentedView.frame.origin.y = screenHeight
            UIView.animate(withDuration: animatinoDuration, animations: {
                presentedView.frame.origin.y = 0
                transitionContext.containerView.alpha = 1
            }) { (_) in
                transitionContext.completeTransition(true)
            }
        }
        
    }
    
    
    //消失动画
    fileprivate func animationForDismissedView(_ transitionContex: UIViewControllerContextTransitioning) {

        switch self.presentAnimatorEndStyle {
        case .animator:
            
            let dismissView = transitionContex.view(forKey: UITransitionContextViewKey.from)
            
            //执行动画
            UIView.animate(withDuration: animationEndDuration, animations: { () -> Void in
                transitionContex.containerView.alpha = 0
                dismissView?.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
            }, completion: { (_) -> Void in
                dismissView?.removeFromSuperview()
                //必须告诉转场上下文你已经完成动画
                transitionContex.completeTransition(true)
            })
        case .up:
            let dismissView = transitionContex.view(forKey: UITransitionContextViewKey.from)
            //执行动画
            UIView.animate(withDuration: animationEndDuration, animations: { () -> Void in
                dismissView?.transform = CGAffineTransform(translationX: 0, y: -screenHeight)
            }, completion: { (_) -> Void in
                dismissView?.removeFromSuperview()
                //必须告诉转场上下文你已经完成动画
                transitionContex.completeTransition(true)
            })
            
        case .rightAnimator:
            let dismissView = transitionContex.view(forKey: UITransitionContextViewKey.from)
            //执行动画
            UIView.animate(withDuration: animationEndDuration, animations: { () -> Void in
                dismissView?.transform = CGAffineTransform(translationX: screenWidth, y: 0)
                transitionContex.containerView.alpha = 0
            }, completion: { (_) -> Void in
                dismissView?.removeFromSuperview()
                //必须告诉转场上下文你已经完成动画
                transitionContex.completeTransition(true)
            })
            
        case .noneAnimator:
            let dismissView = transitionContex.view(forKey: UITransitionContextViewKey.from)
            UIView.animate(withDuration: animationEndDuration, animations: { () -> Void in
                transitionContex.containerView.alpha = 0
            }, completion: { (_) -> Void in
                dismissView?.removeFromSuperview()
                //必须告诉转场上下文你已经完成动画
                transitionContex.completeTransition(true)
            })
            
        case .default:
            let dismissView = transitionContex.view(forKey: UITransitionContextViewKey.from)
            UIView.animate(withDuration: animationEndDuration, animations: { () -> Void in
                transitionContex.containerView.alpha = 0
                dismissView?.transform = CGAffineTransform(translationX: 0, y: screenHeight)
            }, completion: { (_) -> Void in
                dismissView?.removeFromSuperview()
                //必须告诉转场上下文你已经完成动画
                transitionContex.completeTransition(true)
            })
            
        }
    }
}




