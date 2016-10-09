//
//  Finish.swift
//  DecideNow
//
//  Created by 持田章弘 on 2016/10/09.
//  Copyright © 2016年 500hack. All rights reserved.
//

import UIKit

extension UIAlertController{
    class func finish() -> UIAlertController{
        let alert = UIAlertController(title: "Complete", message: "BACK TO TOP", preferredStyle: .alert)
        let yes = UIAlertAction(title: "YES", style: .default, handler: { action in
            
        })
        alert.addAction(yes)
        return alert
    }
}
