//
//  ViewController.swift
//  ZNFish
//
//  Created by 赵恩峰 on 16/8/27.
//  Copyright © 2016年 赵恩峰. All rights reserved.
//


/*********************************************************************
 
 
 欢迎来到 : https://github.com/zhao95/fish  本库尽量标注清晰,使大家能够方便复用
 
 我的Bolg : https://zhao95.github.io/
 
 我的QQ : 3331057077
 
 欢迎朋友们 提交留言和改善建议 谢谢~
 

 *********************************************************************/


import UIKit

class ViewController: UIViewController {
    //三个全局参数
    var fishIndex : Int = 0
    let fishL = CALayer()
    //这里使用了懒加载  [盛放图片的数组]
    lazy var fishArray : [UIImage] = {
        var fishArray = [UIImage]()
        for i in 0..<10 {
            let name = String(format: "fish\(i)")
            let image = UIImage(named: name)
            fishArray.append(image!)
        }
        return fishArray
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK:创建图层
        view.layer.contents = UIImage(named: "bg")?.CGImage
        
        fishL.frame = CGRect(x: 100, y: 288, width: 89, height: 40)
        fishL.contents = UIImage(named: "fish0")?.CGImage
        
        view.layer.addSublayer(fishL)
        
        // MARK:间隔0.1秒调用下边方法
        NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(chang), userInfo: nil, repeats: true)
    }
    // MARK:被调用的方法,显示数组内1~10的图片  出现了鱼摇摆的画面
    func chang() {
        fishIndex += 1
        print(fishIndex)
        if fishIndex == 10 {
            fishIndex = 0
        }
        let image = self.fishArray[fishIndex]
        print(image)
        fishL.contents = image.CGImage
    }
    // MARK:点击图片鱼开始按照一定的路径游动
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //添加动画
        let anim = CAKeyframeAnimation()
        anim.keyPath = "position"
        
        //开启路径
        let path = UIBezierPath()
        
        // MARK:🐟的游动路径......
        path.moveToPoint(CGPoint(x: 100, y: 288))
        path.addLineToPoint(CGPoint(x: 100, y: 100))
        path.addQuadCurveToPoint(CGPoint(x: 300, y: 400), controlPoint: CGPoint(x: 300, y: 20))
        path.addLineToPoint(CGPoint(x: 100, y: 288))
        
        //根据一个路径做动画
        anim.path = path.CGPath;
        //设置旋转模式
        anim.rotationMode = "autoReverse"
        //设置时间模型
        anim.calculationMode = "cubicPaced"
        //动画次数
        anim.repeatCount = HUGE;
        //速度
        anim.duration = 4
        
        //添加动画 forKey 只是个标签任意填写
        fishL.addAnimation(anim, forKey: "fish")
    }
}

