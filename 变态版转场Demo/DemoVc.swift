//
//  DemoVc.swift
//  变态版转场Demo
//
//  Created by 苏文潇 on 2018/1/11.
//  Copyright © 2018年 bestsu. All rights reserved.
//

import UIKit

//  直接继承自 KRBaseTranslationAnimaitonController控制器即可，你想加什么模式随你喽....
class DemoVc: KRBaseTranslationAnimaitonController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.animator?.presentAnimatorStyle = .default
        self.animator?.presentAnimatorEndStyle = .default
        self.animator?.animatinoDuration = 0.3
        self.animator?.animationEndDuration = 0.3
        
        view.addSubview(bgView)
        bgView.center = self.view.center
        bgView.bounds = CGRect(x: 0, y: 0, width: 400, height: 400)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.orange
        return view
    }()
    
    
    deinit {
        print("xiao hui ....")
    }
}


