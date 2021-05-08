//
//  LoginController.swift
//  Eventi
//
//  Created by iedstudent on 08/05/2021.
//  Copyright © 2021 Larisa Pantazi. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //arrotondo gli angoli del btn
        UIHelper.CircleRound(view: btnLogin)
        UIHelper.CircleRound(view: containerGoogsle)
        UIHelper.CircleRound(view: containerFb)
        UIHelper.CircleRound(view: containerIg)

        
 
    }
    
    //MARK: - Outlets
    
    @IBOutlet weak var btnLogin: UIButton!
    
    @IBOutlet weak var containerGoogle: UIView!
    @IBOutlet weak var containerFb: UIView!
    @IBOutlet weak var containerIg: UIView!
    
     //MARK: - Setup
    
}
