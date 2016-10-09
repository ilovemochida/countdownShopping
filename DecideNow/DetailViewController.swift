//
//  DetailViewController.swift
//  DecideNow
//
//  Created by 持田章弘 on 2016/10/08.
//  Copyright © 2016年 500hack. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController{
    
    var currentItem: Item!
    var myScrollView: UIScrollView!
    var timer: Timer!
    var countdown: UIImageView!
    var timeLabel: UILabel!
    var count = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let price: Int = currentItem.price
        
        self.view.backgroundColor = UIColor.rgba(r: 248, g: 248, b: 248, a: 1.0)
        self.view.addSubview(UIView.makeHeader())
        self.view.addSubview(UIView.makeUpper(price: "$" + String(price)))
        
        let footer = UIView.makeFooter()
        var frame = CGRect(x: 90, y: 5, width: 50, height: 50)
        let nextButton = UIButton.nextButton(frame: frame)
        nextButton.addTarget(self, action: #selector(self.goNext), for: .touchUpInside)
        
        frame = CGRect(x: Const.SCREEN_WIDTH - 90 - 50, y: 5, width: 50, height: 50)
        let buyButton = UIButton.buyButton(frame: frame)
        buyButton.addTarget(self, action: #selector(self.goBuy), for: .touchUpInside)
        
        footer.addSubview(nextButton)
        footer.addSubview(buyButton)
        self.view.addSubview(footer)
        
        self.view.addSubview(UIScrollView.itemDetail(item: self.currentItem))
        
        timeInit()
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateTime), userInfo: nil, repeats: true)
        self.timer.fire()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if Const.app.detailToBuy == true{
            Const.app.detailToBuy = false
            self.goNext()
        }
    }
    
    func timeInit(){
        countdown = UIImageView.makeCountDownView(frame: CGRect(x: Const.SCREEN_WIDTH - 60, y: 72, width: 50, height: 50))
        self.view.addSubview(countdown)
        self.view.bringSubview(toFront: countdown)
        
        timeLabel = UILabel()
        timeLabel.frame = CGRect(x: 0, y: 0, width: 120, height: 120)
        timeLabel.text = "\(self.count)"
        timeLabel.font = UIFont.systemFont(ofSize: 25)
        timeLabel.sizeToFit()
        timeLabel.textColor = UIColor.white
        timeLabel.backgroundColor = UIColor.clear
        timeLabel.layer.position = countdown.center
        self.view.addSubview(timeLabel)
    }
    func updateTime(_ timer: Timer){
        self.count -= 1
        if self.count == 0{
            timer.invalidate()
            timeLabel.removeFromSuperview()
            countdown.removeFromSuperview()
            self.goNext()
        }else{
            timeLabel.text = "\(self.count)"
            timeLabel.font = UIFont.systemFont(ofSize: CGFloat(50 - CGFloat(self.count) * 0.8))
            timeLabel.sizeToFit()
            countdown.frame.size.width += 5 / 3
            countdown.frame.size.height += 5 / 3
            countdown.layer.cornerRadius += 2.5 / 3
            countdown.frame.origin.x -= 5 / 3
            countdown.frame.origin.y += 2.5 / 3
            timeLabel.layer.position = countdown.center
        }
    }
    
    func goNext(){
        Const.app.flag = true
        self.dismiss(animated: true, completion: nil)
    }
    
    func goBuy(){
        let buy = PurchaceViewController()
        Const.app.detailToBuy = true
        self.present(buy, animated: true, completion: nil)
    }
    
}
