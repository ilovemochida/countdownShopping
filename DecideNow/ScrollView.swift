//
//  ScrollView.swift
//  DecideNow
//
//  Created by 持田章弘 on 2016/10/08.
//  Copyright © 2016年 500hack. All rights reserved.
//

import UIKit

extension UIScrollView{
    class func itemDetail() -> UIScrollView{
        let scroll = UIScrollView()
        scroll.frame = CGRect(x: 0, y: 112, width: Const.SCREEN_WIDTH, height: Const.SCREEN_HEIGHT - 112 - 50)
        scroll.contentSize = CGSize(width: Const.SCREEN_WIDTH, height: Const.SCREEN_HEIGHT)
        
        let itemTitle = UILabel()
        itemTitle.frame = CGRect(x: 0, y: 10, width: Const.SCREEN_WIDTH, height: 30)
        itemTitle.text = "商品タイトル"
        itemTitle.textAlignment = NSTextAlignment.center
        itemTitle.textColor = UIColor.black
        scroll.addSubview(itemTitle)
        
        let itemImage = UIImageView()
        itemImage.frame = CGRect(x: Const.SCREEN_WIDTH * 0.05, y: itemTitle.frame.maxY + 10, width: Const.SCREEN_WIDTH * 0.9, height: Const.SCREEN_WIDTH * 0.9)
        itemImage.af_setImage(withURL: URL(string: "http://omosoku.com/wp-content/uploads/misawa-225x300.gif")!)
        scroll.addSubview(itemImage)
        
        let line = UIView.makeLine(y: itemImage.frame.maxY + 20)
        scroll.addSubview(line)
        
        let text = UITextView()
        text.frame = CGRect(x: 40, y: line.frame.maxY + 20, width: Const.SCREEN_WIDTH - 80, height: Const.SCREEN_HEIGHT)
        text.text = "商品説明はいります"
        text.backgroundColor = UIColor.clear
        text.textColor = UIColor.rgba(r: 120, g: 120, b: 120, a: 1.0)
        text.isEditable = false
        text.sizeToFit()
        scroll.addSubview(text)
        
        scroll.contentSize.height = text.frame.maxY + 20
        
        if scroll.contentSize.height <= scroll.frame.height {
            scroll.contentSize.height = scroll.frame.height
        }
        
        return scroll
    }
}
