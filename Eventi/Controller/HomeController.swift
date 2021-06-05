//
//  HomeController.swift
//  Eventi
//
//  Created by iedstudent on 15/05/2021.
//  Copyright © 2021 Larisa Pantazi. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    @IBOutlet weak var WelcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nome = LoginHelper.loggedUser?.nome ?? ""
        self.WelcomeLabel.text = "Benvenuto \(nome)"
    }
    


}
