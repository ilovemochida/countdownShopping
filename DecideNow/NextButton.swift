//
//  NextButton.swift
//  DecideNow
//
//  Created by 持田章弘 on 2016/10/08.
//  Copyright © 2016年 500hack. All rights reserved.
//

import UIKit

extension UIButton{
    class func nextButton(frame: CGRect) -> UIButton{
        let button:UIButton =  UIButton()
        button.frame = frame
        button.backgroundColor = UIColor.red
        button.setTitle("NEXT", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }
}
