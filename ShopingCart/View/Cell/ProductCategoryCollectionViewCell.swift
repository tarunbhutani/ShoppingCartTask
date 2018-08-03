//
//  ProductCategoryCollectionViewCell.swift
//  ShopingCart
//
//  Created by InSynchro M SDN BHD on 01/08/2018.
//  Copyright © 2018 Insynchro. All rights reserved.
//

import UIKit

class ProductCategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet var categoryName: UILabel!
    
    var viewModel : CategoryItemViewModelProtocol! {
        didSet{
            self.viewModel.dataDidChange = { [unowned self ] vm in
                self.categoryName.text = vm.categoryName
            }
        }
    }
    
    func populateItem(category : Category)  {
        self.viewModel = CategoryItemViewModel(category: category)
        self.viewModel.populateData()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
