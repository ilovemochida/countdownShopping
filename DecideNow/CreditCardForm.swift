//
//  CreditCardForm.swift
//  DecideNow
//
//  Created by 持田章弘 on 2016/10/08.
//  Copyright © 2016年 500hack. All rights reserved.
//

import UIKit

extension UITextField{
    class func makeCreditForm(y: CGFloat) -> UITextField{
        let form = UITextField()
        form.frame = CGRect(x: 30, y: y, width: Const.SCREEN_WIDTH - 60, height: 30)
        form.placeholder = "credit number"
        form.keyboardType = .numberPad
        form.backgroundColor = UIColor.white
        form.borderStyle = UITextBorderStyle.roundedRect
        return form
    }
}
