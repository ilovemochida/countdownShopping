//
//  Header.swift
//  DecideNow
//
//  Created by 持田章弘 on 2016/10/08.
//  Copyright © 2016年 500hack. All rights reserved.
//

import UIKit

extension UIView{
    class func makeHeader() -> UIView{
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: Const.SCREEN_WIDTH, height: 64)
        view.backgroundColor = Const.MAIN_COLOR
        
        return view
    }
}
