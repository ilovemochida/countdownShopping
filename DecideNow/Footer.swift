//
//  Footer.swift
//  DecideNow
//
//  Created by 持田章弘 on 2016/10/08.
//  Copyright © 2016年 500hack. All rights reserved.
//

import UIKit

extension UIView{
    class func makeFooter() -> UIView{
        let view = UIView()
        view.frame = CGRect(x: 0, y: Const.SCREEN_HEIGHT - 60, width: Const.SCREEN_WIDTH, height: 60)
        view.backgroundColor = Const.MAIN_BACKGROUND_COLOR
        
        return view
    }
}
