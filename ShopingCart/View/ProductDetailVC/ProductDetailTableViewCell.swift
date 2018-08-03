//
//  ProductDetailTableViewCell.swift
//  ShopingCart
//
//  Created by Tarun Bhutani on 02/08/2018.
//  Copyright © 2018 Tarun Bhutani. All rights reserved.
//

import UIKit

protocol ProductVariantSelectProtocol{
    func variantDidSelectAt(row : Int)
    
}

class ProductDetailTableViewCell: UITableViewCell {

    
    @IBOutlet var lbl_product_price: UILabel!
    
    @IBOutlet var product_tax: UILabel!
    
    @IBOutlet var collectionview_color: UICollectionView!
    
    @IBOutlet var lbl_size: UILabel!
    
    var colorVariant = [String]()
    
    var delegate:ProductVariantSelectProtocol?
    
    var product:Product?
    
    var viewModel : ProductDescriptionViewModelProtocol! {
        didSet{
            self.viewModel.dataDidChange = { [unowned self ] vm in
                self.lbl_product_price.text = vm.productPrice ?? "INR 0"
                self.product_tax.text = vm.tax ?? ""
                self.lbl_size.text = vm.size?.count ?? 0 > 0 ?  ("Size: " + (vm.size ?? "")) : ""
            }
        }
    }
    
    func populateItem(product : Product)  {
        self.product = product
        self.colorVariant = Array(Set(getColorList())) 
        collectionview_color.reloadData()
        self.viewModel = ProductDescriptionViewModel(product: product, selectedVariant: 0, listColor: colorVariant)
        self.viewModel.populateData()
    }
    func getColorList() -> [String] {
        
        return product?.variants?.compactMap({ $0.color ?? "" }) ?? [String]()
        //return product?.variants?.flatMap({ $0.color ?? "" }) ?? [String]()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionview_color.delegate = self
        collectionview_color.dataSource = self
        
        collectionview_color.register(UINib(nibName: "ProductVariantCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductVariantCollectionViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}


extension ProductDetailTableViewCell : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorVariant.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductVariantCollectionViewCell", for: indexPath) as! ProductVariantCollectionViewCell
        let color = colorVariant[indexPath.row]
        cell.populateItem(variant: color)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collect click for size....")
        self.viewModel = ProductDescriptionViewModel(product: self.product!, selectedVariant: indexPath.row, listColor: self.colorVariant)
        self.viewModel.populateData()
    }
}

extension ProductDetailTableViewCell : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 35)
    }
    
}

