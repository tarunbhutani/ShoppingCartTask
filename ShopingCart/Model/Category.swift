//
//  Category.swift
//  ShopingCart
//
//  Created by Tarun Bhutani on 31/07/2018.
//  Copyright © 2018 Tarun Bhutani. All rights reserved.
//

import Foundation

class Category: NSObject, NSCoding {
    var id:Int?
    var name:String?
    var products:[Product]?
    var childCategories:[Int]?
    
    
    init(with json: [String : Any]) {
        super.init()
        self.id = json["id"] as? Int
        self.name = json["name"] as? String
        self.products = getProjectList(list: json["products"])
        self.childCategories = json["child_categories"] as? [Int]
    }
    
    func getProjectList(list : Any?) -> [Product]? {
        guard  let products = list as? NSArray else { return nil }
        var productList = [Product]()
        for productObj in products{
            guard let productJson = productObj as? [String:Any] else {continue}
            productList.append(Product(with: productJson))
        }
        return productList
    }
    
    required init?(coder decoder: NSCoder) {
        if let id = decoder.decodeObject(forKey: "id") as? Int{
            self.id = id
        }
        if let name = decoder.decodeObject(forKey: "name") as? String{
            self.name = name
        }
        if let products = decoder.decodeObject(forKey: "products") as? [Product]{
            self.products = products
        }
        if let childCategories = decoder.decodeObject(forKey: "childCategories") as? [Int] {
            self.childCategories = childCategories
        }
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(name, forKey: "name")
        coder.encode(products, forKey: "products")
        coder.encode(childCategories, forKey: "childCategories")
    }
    
    
}
