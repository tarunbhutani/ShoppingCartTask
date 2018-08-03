//
//  Constant.swift
//  ShopingCart
//
//  Created by InSynchro M SDN BHD on 31/07/2018.
//  Copyright © 2018 Insynchro. All rights reserved.
//

import Foundation

class Constant{
    
    static let url = Bundle.main.url(forResource: "Properties", withExtension: "plist")!
    static var propertyDictionary:NSDictionary? {
        get{
            return NSDictionary(contentsOf: url)
        }
    }
    
    public static var endPointURL:String { get{ return propertyDictionary!["endPointURL"] as! String } }
    
    public static var KEY_PROJECT_CATEGORIES = "KEY_PROJECT_CATEGORIES"
    
    public static var KEY_PROJECT_RANKING = "KEY_PROJECT_RANKING"
}
