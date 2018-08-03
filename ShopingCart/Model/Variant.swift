//
//  Variant.swift
//  ShopingCart
//
//  Created by Tarun Bhutani on 31/07/2018.
//  Copyright © 2018 Tarun Bhutani. All rights reserved.
//

import Foundation

class Variant : NSObject, NSCoding{
    var id:Int?
    var color:String?
    var size:Int?
    var price:Int?
    
    init(with json: [String : Any]) {
        self.id = json["id"] as? Int
        self.color = json["color"] as? String
        self.size = json["size"] as? Int
        self.price = json["price"] as? Int
    }
    
    required init?(coder decoder: NSCoder) {
        if let id = decoder.decodeObject(forKey: "id") as? Int{
            self.id = id
        }
        if let color = decoder.decodeObject(forKey: "color") as? String{
            self.color = color
        }
        if let size = decoder.decodeObject(forKey: "size") as? Int{
            self.size = size
        }
        if let price = decoder.decodeObject(forKey: "price") as? Int{
            self.price = price
        }
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(color, forKey: "color")
        coder.encode(size, forKey: "size")
        coder.encode(price, forKey: "price")
    }
    
}
