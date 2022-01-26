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
    }
    
    @IBAction func btnConfirm(_ sender: Any) {
        AlertHelper.showSimpleAlert(title: "Evento Creato", message: "Hai creato un evento con successo", viewController: self)
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
