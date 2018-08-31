//
//  KRBaseTranslationAnimaitonController.swift
//  变态版转场Demo
//
//  Created by best su on 2018/5/31.
//  Copyright © 2018年 bestsu. All rights reserved.
//

import UIKit

class KRBaseTranslationAnimaitonController: UIViewController {

    //    MARK: 动画器
    var animator: XGAnimater?
///    MARK: 点击透明背景是否允许dismiss  默认dismiss
    var selectBackgroundViewIsDismiss: Bool = true
    /// 点击黑色背景消失的回调
    var dismissCallBack:(()->())?
    
    init(){
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .custom
        self.animator = XGAnimater()
        self.animator?.presentAnimatorStyle = .default
        self.animator?.presentAnimatorEndStyle = .default
        self.animator?.animatinoDuration = 0.3
        self.animator?.animationEndDuration = 0.3
        self.transitioningDelegate = self.animator
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        setGuester()
        setupUserInterface()
    }
    
    func setupUserInterface() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setUI()
    {
        view.addSubview(bgView)
        bgView.frame = self.view.frame
    }
    
    ///添加手势
    private func setGuester(){
        let tabGes = UITapGestureRecognizer(target: self, action: #selector(tapgestureAction))
        bgView.addGestureRecognizer(tabGes)
    }
    
//    MARK: - 如果想逆传值的话可以在子类中重写这个方法,调用dismiss然后回调你想传值的闭包即可
    @objc func tapgestureAction()
    {
        if selectBackgroundViewIsDismiss == true{
            self.dismiss(animated: true, completion: {[weak self] in
                self?.dismissCallBack?()
            })
        }
    }
    
    deinit {
        print(self, "销毁了....🌶🌶🌶")
    }
    
    //    MARK: 背景view
    private lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()

}
