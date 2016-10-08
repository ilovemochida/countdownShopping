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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.rgba(r: 248, g: 248, b: 248, a: 1.0)
        self.view.addSubview(UIView.makeHeader())
        self.view.addSubview(UIView.makeUpper(price: "10,000yen"))
        
        let footer = UIView.makeFooter()
        var frame = CGRect(x: 32, y: 10, width: 100, height: 30)
        let nextButton = UIButton.nextButton(frame: frame)
        nextButton.addTarget(self, action: #selector(self.goNext), for: .touchUpInside)
        
        frame = CGRect(x: Const.SCREEN_WIDTH - 32 - 100, y: 10, width: 100, height: 30)
        let buyButton = UIButton.buyButton(frame: frame)
        buyButton.addTarget(self, action: #selector(self.goBuy), for: .touchUpInside)
        
        footer.addSubview(nextButton)
        footer.addSubview(buyButton)
        self.view.addSubview(footer)
        
        myScrollView = UIScrollView()
        myScrollView.frame = CGRect(x: 0, y: 112, width: Const.SCREEN_WIDTH, height: Const.SCREEN_HEIGHT - 112 - 50)
        myScrollView.contentSize = CGSize(width: Const.SCREEN_WIDTH, height: Const.SCREEN_HEIGHT)
        self.view.addSubview(myScrollView)
    }
    
    func goNext(){
        
    }
    
    func goBuy(){
        
    }
    
}
