//
//  Upper.swift
//  DecideNow
//
//  Created by 持田章弘 on 2016/10/08.
//  Copyright © 2016年 500hack. All rights reserved.
//

import UIKit

extension UIView{
    class func makeUpper(price: String) -> UIView{
        let view = UIView()
        view.frame = CGRect(x: 0, y: 64, width: Const.SCREEN_WIDTH, height: 48)
        view.backgroundColor = UIColor.rgba(r: 248, g: 248, b: 248, a: 1.0)
        
        let line = UIView()
        line.frame = CGRect(x: 0, y: view.frame.height - 1, width: Const.SCREEN_WIDTH, height: 1)
        line.backgroundColor = UIColor.rgba(r: 160, g: 160, b: 160, a: 1.0)
        view.addSubview(line)
        
        let priceLabel = UILabel()
        priceLabel.frame = CGRect(x: Const.SCREEN_WIDTH / 2 - 60, y: 10, width: 120, height: 30)
        priceLabel.text = price
        priceLabel.textAlignment = NSTextAlignment.center
        priceLabel.textColor = UIColor.rgba(r: 50, g: 50, b: 50, a: 1.0)
        view.addSubview(priceLabel)
        
        return view
    }
}
