//
//  ProductRank.swift
//  ShopingCart
//
//  Created by InSynchro M SDN BHD on 31/07/2018.
//  Copyright © 2018 Insynchro. All rights reserved.
//

import Foundation

class ProductRank: NSObject, NSCoding {
    var ranking:String?
    var products:[ProductViewCount]?
    
    init(with json: [String:Any]) {
        super.init()
        self.ranking = json["ranking"] as? String
        self.products = getProjectCount(list: json["products"])
    }
    init(ranking:String, products:[ProductViewCount]? = nil) {
        self.ranking = ranking
        self.products = products
    }
    
    func getProjectCount(list : Any?) -> [ProductViewCount]? {
        guard  let products = list as? NSArray else { return nil }
        var productList = [ProductViewCount]()
        for productObj in products{
            guard let productJson = productObj as? [String:Any] else {continue}
            productList.append(ProductViewCount(with: productJson))
        }
        return productList
    }
    
    required init?(coder decoder: NSCoder) {
        
        if let ranking = decoder.decodeObject(forKey: "ranking") as? String{
            self.ranking = ranking
        }
        
        if let products = decoder.decodeObject(forKey: "products") as? [ProductViewCount]{
            self.products = products
        }
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(ranking, forKey: "ranking")
        coder.encode(products, forKey: "products")
    }
}
