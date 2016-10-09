//
//  SplashViewController.swift
//  DecideNow
//
//  Created by 持田章弘 on 2016/10/09.
//  Copyright © 2016年 500hack. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController{
    
    var items: [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Const.MAIN_COLOR
        
        let image = UIImageView()
        image.frame = CGRect(x: 0, y: 0, width: 300 / 2, height: 512 / 2)
        image.image = #imageLiteral(resourceName: "baloon-white")
        image.layer.position = self.view.center
        self.view.addSubview(image)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        Server.getItems(user_id: 2, completion: {response in
            let size = response.count
            for index in 0..<size{
                self.items.append(Item(json: response, index: index))
            }
            
            sleep(1)
            
            let first = ViewController()
            first.items = self.items
            self.present(first, animated: true, completion: nil)
        })
    }
}
