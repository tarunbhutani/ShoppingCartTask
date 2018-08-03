//
//  Tax.swift
//  ShopingCart
//
//  Created by InSynchro M SDN BHD on 31/07/2018.
//  Copyright © 2018 Insynchro. All rights reserved.
//

import Foundation

class Tax: NSObject, NSCoding {
    
    var name:String?
    var value:Double?
    
    init?(with json : Any?) {
        guard let jsonObj = json as? [String:Any] else {
            return nil
        }
        self.name = jsonObj["name"] as? String
        self.value = jsonObj["value"] as? Double
    }
    
    required init?(coder decoder: NSCoder) {
        if let name = decoder.decodeObject(forKey: "name") as? String{ self.name = name }
        
        if let value = decoder.decodeObject(forKey: "value") as? Double{ self.value = value }
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(value, forKey: "value")
    }
    
}
