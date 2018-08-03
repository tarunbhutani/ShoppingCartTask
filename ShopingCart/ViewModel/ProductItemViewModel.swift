//
//  ProductRankItemViewModel.swift
//  ShopingCart
//
//  Created by Tarun Bhutani on 01/08/2018.
//  Copyright © 2018 Tarun Bhutani. All rights reserved.
//

import Foundation

protocol ProductItemViewModelProtocol : class {
    var productName:String? { get }
    
    var productPrice:Int? { get }
    
    var dataDidChange: ((ProductItemViewModelProtocol) -> ())? { get set }
    
    init(product : Product)
    
    func populateData()
}

class ProductItemViewModel: ProductItemViewModelProtocol {
    let product: Product
    
    var productName: String?
    
    var productPrice: Int?
    
    var dataDidChange: ((ProductItemViewModelProtocol) -> ())?
    
    required init(product: Product) {
        self.product = product
    }
    
    func populateData() {
        self.productName = product.name
        self.productPrice = product.variants?.min(by: { $0.price ?? 0 < $1.price ?? 0})?.price
        self.dataDidChange?(self)
    }
    
    
}
