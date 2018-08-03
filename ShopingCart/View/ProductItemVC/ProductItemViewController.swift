//
//  ProductItemViewController.swift
//  ShopingCart
//
//  Created by Tarun Bhutani on 02/08/2018.
//  Copyright © 2018 Tarun Bhutani. All rights reserved.
//

import UIKit

class ProductItemViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var productList = [Product]()
    var subCategoryList = [Category]()
    var vcTitle: String?
    
    func populateProductList(list : [Product])  {
        self.productList = list
        //self.tableView.reloadData()
    }
    
    func populateSubCategoryList(list : [Category])  {
        self.subCategoryList = list
        //self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleNavigationBar(with: vcTitle)
        initTableView()
        
    }
    
    func initTableView() {
        self.tableView.register(UINib(nibName: "ProductItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductItemTableViewCell")
        self.tableView.register(UINib(nibName: "ProductCategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductCategoryTableViewCell")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueShowProductDetail"{
            guard let viewController = segue.destination as? ProductDetailTableViewController else {return}
            if let product  = sender as? Product{
                viewController.product = product
            }
        }
    }
 

}

extension ProductItemViewController: UITableViewDelegate{}

extension ProductItemViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if (section == 0 && subCategoryList.count > 0 ) || (section == 1 && productList.count > 0 ){
            
            return 40
        }
        
        return 0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 5, width: tableView.bounds.size.width, height: 30))
        
        headerView.backgroundColor = UIColor.clear
        
        let label = UILabel(frame: CGRect(x: 10, y: 15, width: tableView.bounds.size.width - 120, height: 30))
        
        label.attributedText = NSAttributedString(string: section == 0 ? "Sub Categories" : "Products", attributes: [.foregroundColor : UIColor.darkGray, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15.0, weight: .bold)])
        
        headerView.addSubview(label)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 && subCategoryList.count > 0 {
            
            return 140
            
        } else if indexPath.section == 1 && productList.count > 0{
            
            return ((tableView.frame.width)/3 ) * CGFloat(round((Double((productList.count / 3) + 1))))
        }
        
        return 0
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCategoryTableViewCell", for: indexPath) as! ProductCategoryTableViewCell
            cell.delegate = self
            cell.setProductList(list: subCategoryList, direction: .horizontal)
            return cell
            
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductItemTableViewCell", for: indexPath) as! ProductItemTableViewCell
        cell.delegate = self
        cell.setProductList(list: productList, direction: .vertical)
        return cell
    }
}

extension ProductItemViewController : categoriesListProtocol{
    
    func didSelect(at row: Int) {
        if let viewcontroller = self.storyboard?.instantiateViewController(withIdentifier: "ProductItemViewController") as? ProductItemViewController{
            
            viewcontroller.populateProductList(list: getProductItemList(row: row))
            if let categoryList = getProductSubCategoryList(row: row){
                viewcontroller.populateSubCategoryList(list: categoryList)
            }
            viewcontroller.vcTitle = subCategoryList[row].name ?? "N/A"
            
            
            self.navigationController?.pushViewController(viewcontroller, animated: true)
        }
        
    }
    
    func getProductItemList(row : Int) -> [Product]  {
        var totalProducts = [Product]()
        
        if let productsList = subCategoryList[row].products, productsList.count > 0{
            totalProducts.append(contentsOf: productsList)
        }
        
        if let filteredCategoryList = getProductSubCategoryList(row: row){
            for item in filteredCategoryList {
                if let list = item.products, list.count > 0{ totalProducts.append(contentsOf: list) }
            }
        }
        return totalProducts
    }
    func getProductSubCategoryList(row : Int) -> [Category]? {
        if let childCategoryList =  subCategoryList[row].childCategories{
            return subCategoryList.filter({ item in
                return childCategoryList.contains{ $0 == item.id ?? -1 }
            })
        }
        return nil
    }
    
}

extension ProductItemViewController : ProductItemTapProtocol{
    func productDidSelect(product: Product) {
        self.performSegue(withIdentifier: "segueShowProductDetail", sender: product)
    }
}


