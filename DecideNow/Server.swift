//
//  Server.swift
//  DecideNow
//
//  Created by 持田章弘 on 2016/10/09.
//  Copyright © 2016年 500hack. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Server: Any{
    
    static let host = "http://fivehacks.herokuapp.com/"
    
    class func getItems(user_id: Int, completion: ((JSON)->Void)?){
        let url = host + "items"
        let parameters = ["user_id": user_id] as [String: Any]
        Alamofire.request(url, method: HTTPMethod.get, parameters: parameters).validate().responseJSON(completionHandler: {response in
            if response.result.error != nil{
                print(response.result.error)
                let json: JSON = "error"
                completion!(json)
            }else{
                if let value = response.result.value {
                    completion!(JSON(value))
                }
            }
        })

    }
}
