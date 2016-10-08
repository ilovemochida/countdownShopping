//
//  Line.swift
//  DecideNow
//
//  Created by 持田章弘 on 2016/10/08.
//  Copyright © 2016年 500hack. All rights reserved.
//

import UIKit

extension UIView{
    class func makeLine(y: CGFloat) -> UIView{
        let line = UIView()
        line.frame = CGRect(x: Const.SCREEN_WIDTH * 0.1, y: y, width: Const.SCREEN_WIDTH * 0.8, height: 1)
        line.backgroundColor = UIColor.rgba(r: 190, g: 190, b: 190, a: 1.0)
        
        return line
    }
}
