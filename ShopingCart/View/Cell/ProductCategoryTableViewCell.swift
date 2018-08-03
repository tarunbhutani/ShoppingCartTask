//
//  ProductCategoryTableViewCell.swift
//  ShopingCart
//
//  Created by InSynchro M SDN BHD on 01/08/2018.
//  Copyright © 2018 Insynchro. All rights reserved.
//

import UIKit

class ProductCategoryTableViewCell: UITableViewCell {

    
    @IBOutlet var collectioinView: UICollectionView!
    var delegate : categoriesListProtocol?
    var categories = [Category]()
    
    func setProductList(list : [Category], direction : UICollectionViewScrollDirection)  {
        self.categories = list
        self.collectioinView.reloadData()
        if let layout = collectioinView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = direction
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectioinView.delegate = self
        collectioinView.dataSource = self
        
        collectioinView.register(UINib(nibName: "ProductCategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductCategoryCollectionViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

extension ProductCategoryTableViewCell : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCategoryCollectionViewCell", for: indexPath) as! ProductCategoryCollectionViewCell
        let category = categories[indexPath.row]
        cell.populateItem(category: category)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //print("Select at indexpath : ", indexPath.row, " Section ", indexPath.section)
        delegate?.didSelect(at: indexPath.row)
        
    }
    
}

extension ProductCategoryTableViewCell : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width)/3
        return CGSize(width: width, height: width)
    }
    
}

protocol categoriesListProtocol {
    
    func didSelect(at row: Int)
    
}
