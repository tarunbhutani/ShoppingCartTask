//
//  String.swift
//  ShopingCart
//
//  Created by Tarun Bhutani on 01/08/2018.
//  Copyright © 2018 Tarun Bhutani. All rights reserved.
//

import Foundation
import UIKit
extension String {
    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
    
    func substring(_ from: Int) -> String {
        return self.substring(from: self.characters.index(self.startIndex, offsetBy: from))
    }
    
    var length: Int {
        return self.characters.count
    }
    func removeWhiteSpace() -> String {
        return self.trimmingCharacters(in: .whitespaces)
    }
    
}
