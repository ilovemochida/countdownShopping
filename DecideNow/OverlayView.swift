//
//  OverlayView.swift
//  DecideNow
//
//  Created by 持田章弘 on 2016/10/08.
//  Copyright © 2016年 500hack. All rights reserved.
//

import Foundation
import UIKit

enum GGOverlayViewMode: Int {
    case Left
    case Right
}

class OverlayView: UIView{
    var mode: GGOverlayViewMode?
    var imageView: UIImageView = UIImageView()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        imageView = UIImageView(image:UIImage(named: "noButton"))
        self.addSubview(imageView)
    }
    
    func setMode(mode: GGOverlayViewMode) {
        print("load setMode")
        
        print(mode)
        if mode == GGOverlayViewMode.Left {
            imageView.image = UIImage(named: "noButton")
        } else {
            imageView.image = UIImage(named: "yesButton")
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
    }
}
