//
//  MakeLabel.swift
//  DecideNow
//
//  Created by 持田章弘 on 2016/10/08.
//  Copyright © 2016年 500hack. All rights reserved.
//

import UIKit

extension UILabel{
    class func makeLabel(y: CGFloat, text: String) -> UILabel{
        let label = UILabel()
        label.frame = CGRect(x: 30, y: y, width: Const.SCREEN_WIDTH - 60, height: 30)
        label.text = text
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 18)
        
        return label
    }
}
