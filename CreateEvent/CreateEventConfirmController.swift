//
//  CreateEventConfirmController.swift
//  Eventi
//
//  Created by iedstudent on 26/01/22.
//  Copyright © 2022 Larisa Pantazi. All rights reserved.
//

import UIKit

class CreateEventConfirmController: UIViewController {
    
    var eventToCreate: CreateEvent!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
            
        self.title = "Riepilogo"
        
        
    }
    
    @IBAction func btnConfirm(_ sender: Any) {
        //l'indirizzo dell'API da richiamare
        let url = "https://edu.davidebalistreri.it/app/api/evento.php"
        
        //preparo i parametri da inviare al srver
        var parameters = DBDictionary()
        
        parameters["nome"] = self.eventToCreate.nome
        parameters["descrizione"] = self.eventToCreate.descrizione
        parameters["prezzo"] = self.eventToCreate.prezzo
        parameters["indirizzo"] = self.eventToCreate.indirizzo
        parameters["lat"] = self.eventToCreate.lat
        parameters["lng"] = self.eventToCreate.lng
        parameters["data"] = self.eventToCreate.timestamp
        
        // manca la cover perché è un file
        //la cover deve essere inviata come file qundi converto
        // la UIImage in un array ddi byte "Data"
        let coveData =
        self.eventToCreate.coverToUpload?.jpegData(compressionQuality: 0.9)
        
        
        // creo un multipart file da passare nella richiesta POST
        let coverFile = DBNetworkingMultipartFile(parameter: "cover", name: "cover.jpg", mimeType: "image/jpg", data: coveData!)
        
        // prendo l'authtoken dell'utente connesso
        let token = LoginHelper.loggedUser?.auth_token
        
        ProgressHUD.show()
        
        // invio la richiesta al server
        DBNetworking.jsonMultipartPost(url: url, authToken: token, parameters: parameters, multipartFiles: [coverFile]) {
            (response: DBNetworkingResponse) in
            ProgressHUD.dismiss()
            
            if response.success == false {
                AlertHelper.showSimpleAlert(title: "Errore server", message: "Servizio momentaneamente non disponibile, riprova più tardi", viewController: self)
            } else {
                AlertHelper.showSimpleAlert(title: "Evento Creato", message: "Hai creato un evento con successo", viewController: self) {
                    self.navigationController?.dismiss(animated: true)
                }
            }
            
        }
        
        
    
        
        
    }

    // MARK: - Navigation

     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // questta funzione viene richiamata automaticamente dallo storyboard quando si passa
         // da un view controller all'altro
         if let nextController = segue.destination as? CreateEventConfirmController {
             // la prossima pagina è quella della data
             
             // gli passo l'evento in fase di creazione
             nextController.eventToCreate = self.eventToCreate
         }
     }

}
