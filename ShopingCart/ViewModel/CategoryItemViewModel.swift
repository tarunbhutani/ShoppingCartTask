//
//  CategoryItemViewModel.swift
//  ShopingCart
//
//  Created by Tarun Bhutani on 01/08/2018.
//  Copyright © 2018 Tarun Bhutani. All rights reserved.
//

import Foundation

protocol CategoryItemViewModelProtocol : class {
    
    var categoryName:String? { get }
    
    
    var dataDidChange: ((CategoryItemViewModelProtocol) -> ())? { get set }
    
    init(category : Category)
    
    func populateData()
}

class CategoryItemViewModel: CategoryItemViewModelProtocol {
    
    let category: Category
    
    var categoryName: String?
    
    
    var dataDidChange: ((CategoryItemViewModelProtocol) -> ())?
    
    required init(category: Category) {
        self.category = category
    }
    
    func populateData() {
        self.categoryName = category.name ?? "N/A"
        self.dataDidChange?(self)
    }
    
}
