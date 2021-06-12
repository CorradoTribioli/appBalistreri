//
//  ProfileController.swift
//  Eventi
//
//  Created by iedstudent on 12/06/2021.
//  Copyright © 2021 Larisa Pantazi. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Actions
    @IBAction func btnLogout(_ sender: Any) {
        //disconnetto l'utente dell'app
        LoginHelper.loggedUser = nil
        LoginHelper.save()
        
        //Torno alla pagina di Splash
        //chiudendo la modale complessiva della TabBar
        self.dismiss(animated: true)
    }
    

}
