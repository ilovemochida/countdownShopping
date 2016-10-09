//
//  Item.swift
//  DecideNow
//
//  Created by 持田章弘 on 2016/10/08.
//  Copyright © 2016年 500hack. All rights reserved.
//

import UIKit
import SwiftyJSON

class Item: NSObject{
    // 商品名
    var name: String!
    // 商品ID
    var id: Int!
    // 値段
    var price: Int!
    // 本来の値段
    var pre_price: Int!
    // 商品説明
    var detail: String!
    // URL
    var image_url: String!
    
    override init(){
        self.name = ""
        self.id = 0
        self.price = 0
        self.pre_price = 0
        self.detail = ""
        self.image_url = ""
    }
    
    init(json: JSON, index: Int) {
        self.name = json[index]["name"].string
        self.id = json[index]["id"].int!
        self.price = json[index]["price"].int!
        self.pre_price = json[index]["pre_price"].int!
        self.detail = json[index]["detail"].string
        self.image_url = json[index]["image"]["url"].string
    }
    
    
}
