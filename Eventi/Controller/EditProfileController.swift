//
//  EditProfileController.swift
//  Eventi
//
//  Created by iedstudent on 16/11/21.
//  Copyright © 2021 Larisa Pantazi. All rights reserved.
//

import UIKit

class EditProfileController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var pckBirthDate: UIDatePicker!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //  UI
        btnSave.layer.cornerRadius = 8
        
        // Precompilo con i dati dell'utente connesso
        let user = LoginHelper.loggedUser!
        txtFirstName.placeholder  = user.nome
        txtLastName.placeholder  = user.cognome
        txtEmail.placeholder  = user.email
        pckBirthDate.date  = user.birthDate
        txtCity.placeholder  = user.citta
        
        // Impedisco di selezionare date nel futuro
        
        pckBirthDate.maximumDate = Date(timeIntervalSinceNow: -(3600*24*365*16))
        
    }
    
    // MARK: - Actions
    @IBAction func btnSave(_ sender: Any) {
        
        // 1. Prendere i dati modificati dall'utente
        let userToUpdate = createUserToUpdate()
        
        // 2. Inviarli al servizio PUT (preso da postman)
        sendUpdatedUserToServer(userToUpdate)
    }
    
    // MARK: - Network
    
    private func createUserToUpdate() -> User {
        let userToUpdate = User()
        
        // Tolgo eventuali spazi all'inizio e alla fine della stringa
        let updatedFirstName = txtFirstName.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        // Procedo solo se la stringa è effettivamente diversa da quella precedente
        if !updatedFirstName.isEmpty, updatedFirstName != LoginHelper.loggedUser?.nome {
            
            // L'utente ha cambiato il suo nome
            userToUpdate.nome = updatedFirstName
        }
        
        // Cognome
        let updatedLastName = txtLastName.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        if !updatedLastName.isEmpty, updatedLastName != LoginHelper.loggedUser?.cognome {
            
            // L'utente ha cambiato il suo nome
            userToUpdate.cognome = updatedLastName
        }
        
        // Email
        let updatedEmail = txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        if !updatedEmail.isEmpty, updatedEmail != LoginHelper.loggedUser?.email {
            
            // L'utente ha cambiato il suo nome
            userToUpdate.email = updatedEmail
        }
        
        // Città
        let updatedCity = txtCity.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        if !updatedCity.isEmpty, updatedCity != LoginHelper.loggedUser?.citta {
            
            // L'utente ha cambiato il suo nome
            userToUpdate.citta = updatedCity
        }
        
        // Data di nascita
        if pckBirthDate.date != LoginHelper.loggedUser?.birthDate {
            userToUpdate.setBirthDateAsString(pckBirthDate.date)
        }
        
        
        return userToUpdate
    }
    private func sendUpdatedUserToServer(_ userToUpdate: User) {
        
        // 1. L'indirizzo dell'API da richiamare
        let url = "https://edu.davidebalistreri.it/app/utente.php"
        
        // 2. Prendo l'auth token
        let token = LoginHelper.loggedUser?.auth_token
        
        // 3. Preparo il dictionary dei parametri aggiornati
        var parametersToSend: [String: Any] = [:]
        
        if userToUpdate.nome != nil {
            parametersToSend["nome"] = userToUpdate.nome
        }
        
        ProgressHUD.show()
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.colorBackground = .lightGray
        ProgressHUD.colorHUD = .systemGray
        
        // 4. Invio la richiesta PUT al server
        DBNetworking.jsonPut(url: url, authToken: token, parameters: parametersToSend) {
            // Questa parte di codice viene eseguita dopo che il server risponda
            (response: DBNetworkingResponse) in
            
            sleep(1)
            ProgressHUD.dismiss()
            
            if response.success == false {
                return
            }
            
            // La richiesta è andata a buon fine
            self.dismiss(animated: true)
        }
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
