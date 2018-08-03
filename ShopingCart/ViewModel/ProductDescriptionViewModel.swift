//
//  ProductDescriptionViewModel.swift
//  ShopingCart
//
//  Created by Tarun Bhutani on 02/08/2018.
//  Copyright © 2018 Tarun Bhutani. All rights reserved.
//

import Foundation

protocol ProductDescriptionViewModelProtocol {
    
    var productPrice:String? { get }
    
    var selectedVariant:Int? {get}
    
    var colorList: [String]? {get}
    
    var tax:String? {get}
    
    var size:String?{get}
    
    var dataDidChange: ((ProductDescriptionViewModelProtocol) -> ())? { get set }
    
    init(product : Product, selectedVariant:Int, listColor : [String])
    
    func populateData()
    
}

class ProductDescriptionViewModel: ProductDescriptionViewModelProtocol {
 
    var product:Product?
    
    var selectedVariant: Int?
    
    var colorList: [String]?
    
    var productPrice: String?
    
    var tax: String?
    
    var size: String?
    
    var dataDidChange: ((ProductDescriptionViewModelProtocol) -> ())?
    
    required init(product: Product, selectedVariant:Int, listColor : [String]) {
        self.product = product
        self.selectedVariant = selectedVariant
        self.colorList = listColor
    }
    
    func populateData() {
        
        let sortedPrice = product?.variants?.sorted(by: { $0.price ?? 0 < $1.price ?? 0})
        let priceRange:String = (sortedPrice?.first?.price ?? 0 == sortedPrice?.last?.price ?? 0 ) ? "\(sortedPrice?.first?.price ?? 0)" : "\( sortedPrice?.first?.price ?? 0) - \(sortedPrice?.last?.price ?? 0)"
        
        self.productPrice = "INR " + priceRange
        self.tax = (product?.tax?.value ?? "") + "% " + (product?.tax?.name ?? "")
        self.size = getSize()
        self.dataDidChange?(self)
    }
    
    func getSize() -> String {
        var finalSize = ""
        
        let sizeList = product?.variants?.filter{ $0.color ?? "" == self.colorList?[selectedVariant ?? 0 ] ?? ""}.compactMap{ $0.size ?? 0 } ?? [Int]()
        
        for (index, size) in sizeList.enumerated() {
            if size == 0 { continue }
            finalSize += "\(size)"
            if index != sizeList.count - 1{
                finalSize += ", "
            }
        }
        return finalSize
    }
    
}
