//
//  ProductVariantViewModel.swift
//  ShopingCart
//
//  Created by Tarun Bhutani on 02/08/2018.
//  Copyright © 2018 Tarun Bhutani. All rights reserved.
//

import Foundation

protocol ProductVariantViewModelProtocol : class {
    
    var variantName:String? { get }
    
    var dataDidChange: ((ProductVariantViewModelProtocol) -> ())? { get set }
    
    init(variant : String)
    
    func populateData()
}

class ProductVariantViewModel: ProductVariantViewModelProtocol {
    var variant:String?
    
    var variantName: String?{
        didSet{
            self.dataDidChange?(self)
        }
    }
    
    var dataDidChange: ((ProductVariantViewModelProtocol) -> ())?
    
    required init(variant: String) {
        self.variant = variant
    }
    func populateData() {
        self.variantName = variant
    }
}
