//
//  ViewController.swift
//  变态版转场Demo
//
//  Created by 苏文潇 on 2018/1/11.
//  Copyright © 2018年 bestsu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.red
        button.addTarget(self, action: #selector(btnClck), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.brown
        view.addSubview(button)
        button.center = self.view.center
        button.bounds = CGRect(x: 0, y: 0, width: 50, height: 50)

    }

    @objc private func btnClck(){
    /*
        专场的控制器 直接继承自 KRBaseTranslationAnimaitonController 即可
        如果你想加什么样式，自己可已在 XGAnimater这个动画器中加的 随你喽...
    */
        let vc = DemoVc()
        self.present(vc, animated: true, completion: nil)
    }
}

