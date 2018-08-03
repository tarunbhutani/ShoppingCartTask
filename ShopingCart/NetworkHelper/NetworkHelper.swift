//
//  NetworkHelper.swift
//  ShopingCart
//
//  Created by InSynchro M SDN BHD on 31/07/2018.
//  Copyright © 2018 Insynchro. All rights reserved.
//

import Foundation

class NetworkHelper: NSObject {
    
    public class var sharedInstance: NetworkHelper{
        struct NetworkHelperSingleton {
            static let instance = NetworkHelper()
        }
        return NetworkHelperSingleton.instance
    }
    
    func call(withEndPoint url: String, completion: @escaping (Data?) -> ()){
        
        print("output: url is:-\(url)")
        
        let Url = URL(string: url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
        
        print("uRL IS",Url)
        
        
        let request = NSMutableURLRequest(url: Url,cachePolicy: .useProtocolCachePolicy, timeoutInterval:60)
        request.httpMethod = "GET" // POST ,GET, PUT What you want
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request as URLRequest) {data,response,error in
            DispatchQueue.main.async(execute: {
                completion(data)
            })
        }
        
        dataTask.resume()
    }
    
}
