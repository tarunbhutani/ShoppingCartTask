//
//  RoundedUIView.swift
//  ShopingCart
//
//  Created by Tarun Bhutani on 01/08/2018.
//  Copyright © 2018 Tarun Bhutani. All rights reserved.
//

import Foundation
import UIKit

class RoundedUIView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBInspectable
    public var viewCornerRadius:CGFloat = 0.0{
        didSet{
            self.layer.cornerRadius = self.viewCornerRadius
        }
    }
    @IBInspectable
    public var myBackgroundColor:UIColor = UIColor.clear{
        didSet{
            self.layer.backgroundColor = self.myBackgroundColor.cgColor
        }
    }
    @IBInspectable
    public var viewBorderWidth:CGFloat = 0.0{
        didSet{
            self.layer.borderWidth = self.viewBorderWidth
        }
    }
    @IBInspectable
    public var viewBorderColor:UIColor = UIColor.clear{
        didSet{
            self.layer.borderColor = self.viewBorderColor.cgColor
        }
    }
}
