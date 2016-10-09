//
//  CountDown.swift
//  DecideNow
//
//  Created by 持田章弘 on 2016/10/09.
//  Copyright © 2016年 500hack. All rights reserved.
//

import UIKit

extension UIView{
    class func makeCountDownView(frame: CGRect) -> UIView{
        let view = UIView()
        view.frame = frame
        view.backgroundColor = UIColor.rgba(r: 7, g: 255, b: 7, a: 1.0)
        view.layer.masksToBounds = true
        view.layer.cornerRadius = view.frame.width / 2
        
        return view
    }
}
