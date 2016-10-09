//
//  ErrorAlert.swift
//  DecideNow
//
//  Created by 持田章弘 on 2016/10/09.
//  Copyright © 2016年 500hack. All rights reserved.
//

import UIKit

extension UIAlertController{
    class func errorAlert() -> UIAlertController{
        let alert = UIAlertController(title: "ERROR", message: "Please enter all of the information", preferredStyle: .alert)
        let yes = UIAlertAction(title: "YES", style: .default, handler: nil)
        alert.addAction(yes)
        return alert
    }
}
