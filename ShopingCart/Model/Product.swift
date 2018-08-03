//
//  Product.swift
//  ShopingCart
//
//  Created by Tarun Bhutani on 31/07/2018.
//  Copyright © 2018 Tarun Bhutani. All rights reserved.
//

import Foundation

class Product : NSObject, NSCoding{
    var id:Int?
    var name:String?
    var dateAdded:String?
    var variants:[Variant]?
    var tax:Tax?
    var count:Int?
    
    init(with json: [String : Any]) {
        super.init()
        self.id = json["id"] as? Int
        self.name = json["name"] as? String
        self.dateAdded = json["date_added"] as? String
        self.variants = getVariantList(list: json["variants"])
        self.tax = Tax(with: json["tax"])
    }
    
    func getVariantList(list : Any?) -> [Variant]? {
        guard  let variants = list as? NSArray else { return nil }
        var variantList = [Variant]()
        for variantObj in variants{
            guard let variantJson = variantObj as? [String:Any] else {continue}
            variantList.append(Variant(with: variantJson))
        }
        return variantList
    }
    
    required init?(coder decoder: NSCoder) {
        if let id = decoder.decodeObject(forKey: "id") as? Int{
            self.id = id
        }
        if let name = decoder.decodeObject(forKey: "name") as? String{
            self.name = name
        }
        if let dateAdded = decoder.decodeObject(forKey: "dateAdded") as? String{
            self.dateAdded = dateAdded
        }
        if let variants = decoder.decodeObject(forKey: "variants") as? [Variant] {
            self.variants = variants
        }
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(name, forKey: "name")
        coder.encode(dateAdded, forKey: "dateAdded")
        coder.encode(variants, forKey: "variants")
    }
    
}
