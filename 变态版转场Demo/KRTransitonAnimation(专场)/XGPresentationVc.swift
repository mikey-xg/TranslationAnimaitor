//
//  XGPresentationVc.swift
//  变态版转场Demo
//
//  Created by best su on 2018/5/31.
//  Copyright © 2018年 bestsu. All rights reserved.
//

import UIKit

class XGPresentationVc: UIPresentationController {
    //    MARK: 转场的view的frame
    var presentedFrame : CGRect = CGRect.zero
    //    MARK: 转场的view的背景颜色
    var presentedBgColor: UIColor = UIColor.init()
    //    MARK: 底部带背景颜色的view的frame
    var coverFrame: CGRect = CGRect.zero
    //    MARK:给coverView添加背景颜色
    var coverViewBgColor: UIColor = UIColor.init()
    // MARK: 蒙板view
    private lazy var coverView : UIView = UIView()
    //    MARK: containerView  容器view
    var containView: UIView!
    
    //MARK: - 系统回调函数
    override func containerViewWillLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        //     设置弹出View的尺寸,首先拿到容器view
        self.containView = self.containerView!
//        转场显示的控制器的view  即第二个view
        let toView = self.presentedView
        self.containView.addSubview(toView!)
        toView?.frame = presentedFrame
        toView?.backgroundColor = presentedBgColor
        setupCoverView()
    }
    
    //    MARK:  添加蒙板
    private func setupCoverView()
    {
        containerView?.insertSubview(coverView, at: 0)
        coverView.backgroundColor = coverViewBgColor
        coverView.frame = coverFrame
        //添加手势
        let tabGes = UITapGestureRecognizer(target: self, action: #selector(tapgestureAction))
        coverView.addGestureRecognizer(tabGes)
        
    }
    
    
    @objc private func tapgestureAction()
    {
        presentedViewController.dismiss(animated: true, completion: nil)
    }
    
    
    
}
