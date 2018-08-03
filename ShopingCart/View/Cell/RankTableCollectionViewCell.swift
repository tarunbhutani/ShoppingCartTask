//
//  RankTableCollectionViewCell.swift
//  ShopingCart
//
//  Created by InSynchro M SDN BHD on 01/08/2018.
//  Copyright © 2018 Insynchro. All rights reserved.
//

import UIKit

class RankTableCollectionViewCell: UICollectionViewCell {

    @IBOutlet var productName: UILabel!
    @IBOutlet var price: UILabel!
    
    var viewModel : ProductItemViewModelProtocol! {
        didSet{
            self.viewModel.dataDidChange = { [unowned self ] vm in
                self.productName.text = vm.productName
                self.price.text = "INR " + "\(vm.productPrice!)"
            }
        }
    }
    
    func populateItem(product : Product)  {
        self.viewModel = ProductItemViewModel(product: product)
        self.viewModel.populateData()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
