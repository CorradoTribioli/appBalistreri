//
//  ProfileController.swift
//  Eventi
//
//  Created by iedstudent on 12/06/2021.
//  Copyright © 2021 Larisa Pantazi. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {

    //l'utente
    var userToShow: User! = LoginHelper.loggedUser
    
    // MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthDateLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var img_profile: UIImageView!
    @IBOutlet weak var btnLogout: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameLabel.text = userToShow.nomeCompleto
        self.birthDateLabel.text = userToShow.data_nascita
        self.cityLabel.text = userToShow.citta
        self.img_profile.setImageWithUrlString(userToShow.avatar_url)
        UIHelper.CircleRound(view: self.img_profile)
        UIHelper.CircleRound(view: self.btnLogout)
        
        if userToShow?.id_utente != LoginHelper.loggedUser?.id_utente{
            btnLogout.isHidden=true
        }
    }
    
    // MARK: - Actions
    @IBAction func btnLogout(_ sender: Any) {
        //disconnetto l'utente dell'app
        LoginHelper.loggedUser = nil
        LoginHelper.save()
        
        //Torno alla pagina di Splash
        //chiudendo la modale complessiva della TabBar
        dismiss(animated: true)
        
        
    }

}
