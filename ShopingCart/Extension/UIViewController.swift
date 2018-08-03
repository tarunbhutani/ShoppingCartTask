//
//  UIViewController.swift
//  ShopingCart
//
//  Created by Tarun Bhutani on 02/08/2018.
//  Copyright © 2018 Tarun Bhutani. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func styleNavigationBar(with text: String?) {
        
        self.navigationController?.navigationBar.tintColor = UIColor(hex: "#929292")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.title = text
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor(hex: "#5E5E5E"), NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15.0, weight: .semibold)]
        
    }
    
}
