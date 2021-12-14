//
//  CreateEventNameController.swift
//  Eventi
//
//  Created by iedstudent on 07/12/21.
//  Copyright © 2021 Larisa Pantazi. All rights reserved.
//

import UIKit

class CreateEventNameController: UIViewController, UITextFieldDelegate {
    
    // questo è l'evento in fase di creazione che è
    // condiviso da tutte le pagine di questo flusso
    let eventToCreate = CreateEvent()
    
    //MARK: - Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.txtDescription.text = ""
        
        self.txtPrice.inputAccessoryView = self.toolbar
        
        //UI
        self.txtDescription.layer.cornerRadius = 5
        self.txtDescription.layer.borderWidth = 0.5
        self.txtDescription.layer.borderColor = UIColor.gray.withAlphaComponent(0.3).cgColor

        // Do any additional setup after loading the view.
        
    }
    
    //MARK: - Outlets
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet var toolbar: UIToolbar!
    
    //MARK: - Functions
    private func showAlert() {
        AlertHelper.showSimpleAlert(title: "ALERT", message: "il nome è obbligatorio", viewController: self)

    }
    
    private func isFormValid() -> Bool {
        ///questa funzione ritorna true se tutti i campi sono stati compilati correttamente
        let textField = self.txtName.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        if textField == ""  {
            AlertHelper.showSimpleAlert(title: "ALERT", message: "il nome è obbligatorio", viewController: self)
            return false
        } else if textField.count <= 3 {
                AlertHelper.showSimpleAlert(title: "ALERT", message: "il nome è troppo corto", viewController: self)
            return false
        }
        
        // controllo se il prezzo inserito è valido
        if self.txtPrice.text?.isEmpty == false {
            // provo a fare la conversione del testo in un double
            
            let euro = Double(self.txtPrice.text ?? "")
            
            // se la conversione fallisce mostrare un alert
            if euro == nil {
                AlertHelper.showSimpleAlert(title: "ALERT", message: "il prezzo non è valido", viewController: self)
                return false
            }
            
            
            
            
        }
        
        return true
    }
    
    private func fillEventToCreate() {
        // nome
        self.eventToCreate.nome = self.txtName.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // descrizione
        self.eventToCreate.descrizione = self.txtDescription.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // prezzo
        let euro = Double(self.txtPrice.text ?? "") ?? 0
        self.eventToCreate.prezzo = Int(euro * 100)

    }
    //MARK: - Actions
    
    @IBAction func btnClose(_ sender: Any) {
        //chiudo il flusso di creazione evento
        self.dismiss(animated: true)
    }
    
    @IBAction func btnNext(_ sender: Any) {
        if isFormValid() {
            // popolo l'evento in fase di creazione
            self.fillEventToCreate()
            
            //passo alla prossima schermata
            self.performSegue(withIdentifier: "GoToNext", sender: self)
        }
    }
    
    @IBAction func btnDone(_ sender: Any) {
        self.view.endEditing(true)
    }
    

    // MARK: - Navigation
     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // questta funzione viene richiamata automaticamente dallo storyboard quando si passa
        // da un view controller all'altro
        if let nextController = segue.destination as? CreateEventDateController {
            // la prossima pagina è quella della data
            
            // gli passo l'evento in fase di creazione
            nextController.eventToCreate = self.eventToCreate
        }
    }

}
