//
//  ProductColorCollectionViewCell.swift
//  ShopingCart
//
//  Created by InSynchro M SDN BHD on 02/08/2018.
//  Copyright © 2018 Insynchro. All rights reserved.
//

import UIKit

class ProductVariantCollectionViewCell: UICollectionViewCell {

    @IBOutlet var lbl_variant: UILabel!
    
    var viewModel : ProductVariantViewModelProtocol! {
        didSet{
            self.viewModel.dataDidChange = { [unowned self ] vm in
                self.lbl_variant.text = vm.variantName
            }
        }
    }
    
    func populateItem(variant : String)  {
        self.viewModel = ProductVariantViewModel(variant: variant)
        self.viewModel.populateData()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
