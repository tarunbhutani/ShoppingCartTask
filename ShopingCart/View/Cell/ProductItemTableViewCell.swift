//
//  ProductItemTableViewCell.swift
//  ShopingCart
//
//  Created by InSynchro M SDN BHD on 02/08/2018.
//  Copyright © 2018 Insynchro. All rights reserved.
//

import UIKit

class ProductItemTableViewCell: UITableViewCell {

    @IBOutlet var collectioinView: UICollectionView!
    var delegate: ProductItemTapProtocol?
    var products = [Product]()
    
    func setProductList(list : [Product], direction : UICollectionViewScrollDirection)  {
        self.products = list
        self.collectioinView.reloadData()
        if let layout = collectioinView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = direction
        }
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectioinView.delegate = self
        collectioinView.dataSource = self
        
        collectioinView.register(UINib(nibName: "RankTableCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RankTableCollectionViewCell")
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension ProductItemTableViewCell : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RankTableCollectionViewCell", for: indexPath) as! RankTableCollectionViewCell
        let product = products[indexPath.row]
        cell.populateItem(product: product)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.productDidSelect(product: products[indexPath.row])
    }
    
}

extension ProductItemTableViewCell : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (collectionView.frame.width)/3
        return CGSize(width: width, height: width)
    }
    
}
