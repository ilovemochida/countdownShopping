//
//  CountDown.swift
//  DecideNow
//
//  Created by 持田章弘 on 2016/10/09.
//  Copyright © 2016年 500hack. All rights reserved.
//

import UIKit

extension UIImageView{
    class func makeCountDownView(frame: CGRect) -> UIImageView{
        let view = UIImageView()
        view.frame = frame
        view.image = #imageLiteral(resourceName: "baloon")
        
        return view
    }
}
