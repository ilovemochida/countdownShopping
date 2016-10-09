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
        let price: Int = currentItem.price
        
        self.view.backgroundColor = UIColor.rgba(r: 248, g: 248, b: 248, a: 1.0)
        self.view.addSubview(UIView.makeHeader())
        self.view.addSubview(UIView.makeUpper(price: "$" + String(price)))
        
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
        
        self.view.addSubview(UIScrollView.itemDetail(item: self.currentItem))
    }
    
    func goNext(){
        Const.app.flag = true
        self.dismiss(animated: true, completion: nil)
    }
    
    func goBuy(){
        let buy = PurchaceViewController()
        self.present(buy, animated: true, completion: nil)
    }
    
}
