//
//  SplashController.swift
//  Eventi
//
//  Created by iedstudent on 05/06/2021.
//  Copyright © 2021 Larisa Pantazi. All rights reserved.
//

import UIKit

class SplashController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        //carico l'utente connesso (se c'è)
        LoginHelper.load()
        
        if LoginHelper.loggedUser != nil {
            //l'utente ra connesso, vado sulla home
            self.performSegue(withIdentifier: "GoToHome", sender: nil)
        }else {
            //l'uente NON era connesso, vado sulla Welcome
            self.performSegue(withIdentifier: "GoToWelcome", sender: nil)
        }
        
    }
    


}
