//
//  Color.swift
//  DecideNow
//
//  Created by 持田章弘 on 2016/10/08.
//  Copyright © 2016年 500hack. All rights reserved.
//

import UIKit

extension UIColor{
    class func rgba(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor{
        let color = UIColor(red: r / 255, green: g / 255, blue: b / 255, alpha: a)
        return color
    }
}
