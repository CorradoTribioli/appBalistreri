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
    @IBOutlet weak var btnProfileSetting: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //cambio il colore della tabBar
        tabBarController?.tabBar.barTintColor = UIColor.black
        navigationController?.navigationBar.barTintColor = UIColor.black
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    
        UIHelper.CircleRound(view: self.img_profile)
        UIHelper.CircleRound(view: self.btnLogout)
        
        if userToShow?.id_utente != LoginHelper.loggedUser?.id_utente{
            btnLogout.isHidden=true
        }
        self.updateController()
        self.updateLoggedUser()
        
        // mi metto in ascolto della notifica per aggiornare l'utente connesso
        self.addNotificationListener()
    }
    
    private func updateController() {
        self.nameLabel.text = userToShow.nomeCompleto
        self.birthDateLabel.text = userToShow.data_nascita
        self.cityLabel.text = userToShow.citta
        self.img_profile.setImageWithUrlString(userToShow.avatar_url)
    }
    private func addNotificationListener() {
        // mi metto in ascolto della notifica per aggiornare l'utente connesso
        
        let notification = Notification.Name("UpdateLoggedUserNotification")
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateLoggedUser),
                                               name: notification,
                                               object: nil)
    }
    // MARK: - Network
    
    /// questa funzione chiede al server le info dell'utente connesso,
    /// e aggiorna il database locale
    @objc private func updateLoggedUser() {
        
        guard userToShow.id_utente == LoginHelper.loggedUser?.id_utente else {
            // non bisogna aggiornare il profilo di altri utenti
            return
        }
        
        // 1. l'indirizzo dell'API da richiamare
        let url = "https://edu.davidebalistreri.it/app/utente.php"
        
        // 2. prendo l'auth token dell'utente connesso
        let token = LoginHelper.loggedUser?.auth_token
        
        // 3. Invio la richiesta al server
        DBNetworking.jsonGet(url: url, authToken: token, parameters: nil) {
            // Questa parte di codice viene eseguita dopo che il server risponda
            (response: DBNetworkingResponse) in
            
        // 4. trasformo la risposta del server json in uno User
            if response.success {
                
                //mi aspetto che il server abbia inviato un dictioary
                if let dictionary = response.data as? DBDictionary {
                    //prendo l'oggetto 'data' che a sua volta è un dictionary
                    if let data = dictionary["data"] as? DBDictionary {
                        
                        //riconcerto il dictionary in un oggetto JSON
                        let json = try? JSONSerialization.data(withJSONObject: data, options: [])
                        
                        //con un oggetto JSON di tipo  "Data" possiamo ora convertire automaticamente e ottenere un oggetto "User"
                        let user = try? JSONDecoder().decode(User.self, from: json ?? Data())
                        
                        // 5. aggiorno il database locale
                        LoginHelper.loggedUser = user
                        LoginHelper.save()
                        
                        // 6. ricarico la pagina del profilo con i nuovi dati dell'utente
                        // 6a. spostare il codice che carica i dati dell'utente dalla funzione "viewDidLoad" a una nuova funzione "updateController"
                        self.userToShow = user
                        self.updateController()
                    }
                }
                
            }
            
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
