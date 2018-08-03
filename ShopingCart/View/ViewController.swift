//
//  ViewController.swift
//  ShopingCart
//
//  Created by Tarun Bhutani on 31/07/2018.
//  Copyright © 2018 Tarun Bhutani. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK :- Initialization
    
    var projectCategories = [Category]()
    var productRanking = [ProductRank]()
    let categoryRank = ProductRank(ranking: "Categories")
    
    let networkHelper = NetworkHelper.sharedInstance
    
    let queue = DispatchQueue(label: "com.execute.concurrent", qos: .default, attributes: .concurrent)
    
    @IBOutlet var tableView: UITableView!
    
    var categories = ["Action", "Drama", "Science Fiction", "Kids", "Horror"]
    
    func initTableView() {
        self.tableView.register(UINib(nibName: "RankTableViewCell", bundle: nil), forCellReuseIdentifier: "RankTableViewCell")
        self.tableView.register(UINib(nibName: "ProductCategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductCategoryTableViewCell")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleNavigationBar(with: "Shopping Cart")
        initTableView()
        fetchData()
        if let categoriesListData = UserDefaultData.getProjectCategory(){
            self.projectCategories = categoriesListData
        }
        if let rankings = UserDefaultData.getProjectRankings(){
            self.productRanking = rankings
            self.productRanking.append(categoryRank)
        }else{
            self.view.makeToastActivity()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueProductItemVC"{
            guard let viewcontroller = segue.destination as? ProductItemViewController else { return }
            
            if let sender = sender as? UIButton{
                let section = sender.tag
                let productList = getFilteredSortedProductList(section: section)
                viewcontroller.populateProductList(list: productList)
                viewcontroller.vcTitle = productRanking[section].ranking ?? "N/A"
            }
            if let row = sender as? Int{
                viewcontroller.populateProductList(list: getProductItemList(row: row))
                if let categoryList = getProductSubCategoryList(row: row){
                    
                    viewcontroller.populateSubCategoryList(list: categoryList)
                }
                viewcontroller.vcTitle = projectCategories[row].name ?? "N/A"
            }
        }
        if segue.identifier == "segueShowProductDetail"{
            guard let viewController = segue.destination as? ProductDetailTableViewController else {return}
            if let product  = sender as? Product{
                viewController.product = product
            }
        }
        
    }


}


extension ViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerTitel = productRanking[section].ranking ?? "N/A"
        let headerView = UIView(frame: CGRect(x: 0, y: 5, width: tableView.bounds.size.width, height: 30))
        headerView.backgroundColor = UIColor.clear
        
        let label = UILabel(frame: CGRect(x: 10, y: 15, width: tableView.bounds.size.width - 120, height: 30))
        let button = UIButton(frame: CGRect(x: tableView.bounds.size.width - 80, y: 17, width: 80, height: 25))
        button.tag = section
        button.setAttributedTitle(NSAttributedString(string: "See All >", attributes: [.foregroundColor : UIColor.lightGray, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15.0, weight: .regular)]), for: .normal)
        button.addTarget(self, action: #selector(self.seeAll(_:)), for: .touchUpInside)
        
        label.attributedText = NSAttributedString(string: headerTitel, attributes: [.foregroundColor : UIColor.darkGray, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15.0, weight: .bold)])
            
        
        headerView.addSubview(label)
        if headerTitel != "Categories"{
            headerView.addSubview(button)
        }
        
        return headerView
    }
    
    @objc func seeAll(_ sender: UIButton) {
        self.performSegue(withIdentifier: "segueProductItemVC", sender: sender)
        
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if productRanking[indexPath.section].ranking ?? "N/A" == "Categories"{
            return ((tableView.frame.width)/3 ) * CGFloat(round((Double((projectCategories.count / 3) + 1))))
            
        }
        return 140
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return productRanking.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if productRanking[indexPath.section].ranking ?? "N/A" == "Categories"{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCategoryTableViewCell", for: indexPath) as! ProductCategoryTableViewCell
            cell.delegate = self
            cell.setProductList(list: projectCategories, direction: .vertical)
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RankTableViewCell", for: indexPath) as! RankTableViewCell
        cell.delegate = self
        let productList = getFilteredSortedProductList(section: indexPath.section)
       
        cell.setProductList(list: productList)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
}

extension ViewController: UITableViewDelegate{}

// Load Data from server
extension ViewController{
    
    func fetchData()  {
        
        queue.async {
            let endpoint = Constant.endPointURL
            
            self.networkHelper.call(withEndPoint: endpoint) { data in
                guard let result = data else { return }
                
                do{
                    if let jsonResult =  try JSONSerialization.jsonObject(with: result, options: []) as? [String : Any]{
                        
                        // Clear list
                        self.projectCategories = [Category]()
                        self.productRanking = [ProductRank]()
                        
                        if let categoriesList = jsonResult["categories"] as? NSArray{
                            
                            for category in categoriesList{
                                guard let categoryJson = category as? [String:Any] else { continue }
                                self.projectCategories.append(Category(with: categoryJson))
                            }
                            
                        }
                        
                        if let rankingList = jsonResult["rankings"] as? NSArray{
                            for rank in rankingList {
                                guard let rankJson = rank as? [String : Any] else {continue}
                                
                                self.productRanking.append(ProductRank(with: rankJson))
                                
                            }
                        }
                        
                        
                    }
                    DispatchQueue.main.async {
                        UserDefaultData.storeProjectRankings(productRankings: self.productRanking)
                        UserDefaultData.storeProjectCategory(categories: self.projectCategories)
                        self.productRanking.append(self.categoryRank)
                        print("self.projectCategories list size ", self.projectCategories.count)
                        self.tableView.reloadData()
                        self.view.hideToastActivity()
                    }
                    
                }catch { print(error.localizedDescription) }
            }
        }
        
    }
    
}


extension ViewController : categoriesListProtocol{
    
    func didSelect(at row: Int) {
        self.performSegue(withIdentifier: "segueProductItemVC", sender: row)
        
    }
    
}
extension ViewController : ProductItemTapProtocol{
    func productDidSelect(product: Product) {
        self.performSegue(withIdentifier: "segueShowProductDetail", sender: product)
    }
    
}


// Data computation
extension ViewController {
    func getFilteredSortedProductList(section : Int) -> [Product] {
        
        var productList = [Product]()
        
        for category in projectCategories{
            
            let products = category.products?.filter( { product in
                return productRanking[section].products?.contains(where: { rank in
                    rank.id ?? -1 == product.id ?? -1
                }) ?? false
            })
            if let filteredList  = products{ productList.append(contentsOf: filteredList) }
            
        }
        if let rankingProduects = productRanking[section].products{
            for item in rankingProduects{
                let index = productList.index(where: { $0.id ?? -1 == item.id ?? -1})
                if let foundIndex = index {
                    let productToAppend = productList[foundIndex]
                    productToAppend.count = item.count
                    productList[foundIndex] = productToAppend
                }
                
            }
        }
        
        return productList.sorted(by: { $0.count ?? 0 > $1.count ?? 0})
    }
    
    func getProductItemList(row : Int) -> [Product]  {
        var totalProducts = [Product]()
        
        if let productsList = projectCategories[row].products, productsList.count > 0{
            totalProducts.append(contentsOf: productsList)
        }
        
        if let filteredCategoryList = getProductSubCategoryList(row: row){
            for item in filteredCategoryList {
                print("category name ", item.name, " availabel product ", item.products?.count)
                if let list = item.products, list.count > 0{ totalProducts.append(contentsOf: list) }
            }
        }
        print("total product found ", totalProducts.count)
        return totalProducts
    }
    func getProductSubCategoryList(row : Int) -> [Category]? {
        if let subCategoryList =  projectCategories[row].childCategories{
            return projectCategories.filter({ item in
                return subCategoryList.contains{ $0 == item.id ?? -1 }
            })
        }
        return nil
    }
}

