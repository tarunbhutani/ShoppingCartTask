//
//  UserDefaultData.swift
//  ShopingCart
//
//  Created by Tarun Bhutani on 31/07/2018.
//  Copyright © 2018 Tarun Bhutani. All rights reserved.
//

import Foundation
class UserDefaultData{
    
    
    static let userDefaults:UserDefaults? = UserDefaults.standard
 
    
    static func getProjectCategory() -> [Category]?{
        
        if(userDefaults?.object(forKey: Constant.KEY_PROJECT_CATEGORIES) != nil){
            let categoryData = userDefaults?.object(forKey: Constant.KEY_PROJECT_CATEGORIES) as! Data
            if let decodedList = NSKeyedUnarchiver.unarchiveObject(with: categoryData) as? [Category]{
                return decodedList
            }
        }
        return nil
    }
    
    public static func storeProjectCategory( categories:[Category]){
        let categoryData = NSKeyedArchiver.archivedData(withRootObject: categories)
        userDefaults?.set(categoryData, forKey: Constant.KEY_PROJECT_CATEGORIES)
        userDefaults?.synchronize()
    }
    
    static func getProjectRankings() -> [ProductRank]?{
        
        if(userDefaults?.object(forKey: Constant.KEY_PROJECT_RANKING) != nil){
            let rankingData = userDefaults?.object(forKey: Constant.KEY_PROJECT_RANKING) as! Data
            if let decodedList = NSKeyedUnarchiver.unarchiveObject(with: rankingData) as? [ProductRank]{
                return decodedList
            }
        }
        return nil
    }
    
    public static func storeProjectRankings( productRankings : [ProductRank]){
        let rankingData = NSKeyedArchiver.archivedData(withRootObject: productRankings)
        userDefaults?.set(rankingData, forKey: Constant.KEY_PROJECT_RANKING)
        userDefaults?.synchronize()
    }
    
}
