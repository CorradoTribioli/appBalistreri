//
//  CartControllerViewController.swift
//  Eventi
//
//  Created by iedstudent on 12/10/21.
//  Copyright © 2021 Larisa Pantazi. All rights reserved.
//

import UIKit

class CartController: UIViewController {
    
//MARK: - Outlets
    
    @IBOutlet weak var lblItemsCount: UILabel!
    @IBOutlet weak var lblTotalPrice: UILabel!
    
//MARK: - Setup
    override func viewDidLoad() {
        super.viewDidLoad()

        self.lblItemsCount.text = "\(CartHelper.items.count)"
    }

    
    
    
    
    
    
    
}
