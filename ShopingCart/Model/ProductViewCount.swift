//
//  ProductViewCount.swift
//  ShopingCart
//
//  Created by Tarun Bhutani on 31/07/2018.
//  Copyright © 2018 Tarun Bhutani. All rights reserved.
//

import Foundation

class ProductViewCount: NSObject, NSCoding {
    
    var id: Int?
    var count:Int?
    init(with json : [String: Any]) {
        self.id = json["id"] as? Int
        self.count = (json["view_count"] ?? json["order_count"]  ?? json["shares"] ) as? Int
    }
    
    required init?(coder decoder: NSCoder) {
        
        if let id = decoder.decodeObject(forKey: "id") as? Int{
            self.id = id
        }
        
        if let count = decoder.decodeObject(forKey: "count") as? Int{
            self.count = count
        }
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(count, forKey: "count")
    }
    
    
}

