//
//  MostViewedTableViewCell.swift
//  ShopingCart
//
//  Created by InSynchro M SDN BHD on 31/07/2018.
//  Copyright © 2018 Insynchro. All rights reserved.
//

import UIKit

class RankTableViewCell: UITableViewCell {

    @IBOutlet var collectionView: UICollectionView!
    var productList = [Product]()
    var delegate : ProductItemTapProtocol?
    
    func setProductList(list : [Product])  {
        self.productList = list
        self.collectionView.reloadData()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.roundCorners(radius: 10)
        
        collectionView.register(UINib(nibName: "RankTableCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RankTableCollectionViewCell")
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}


extension RankTableViewCell : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RankTableCollectionViewCell", for: indexPath) as! RankTableCollectionViewCell
        let product = productList[indexPath.row]
        cell.populateItem(product: product)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = productList[indexPath.row]
        delegate?.productDidSelect(product: product)
    }
}

extension RankTableViewCell : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //return CGSize(width: 130, height: 130)
        let width = (collectionView.frame.width)/3
        return CGSize(width: width, height: width)
    }
    
}


protocol ProductItemTapProtocol {
    func productDidSelect(product: Product)
}
