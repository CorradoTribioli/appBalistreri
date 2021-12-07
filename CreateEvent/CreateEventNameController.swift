//
//  CreateEventNameController.swift
//  Eventi
//
//  Created by iedstudent on 07/12/21.
//  Copyright © 2021 Larisa Pantazi. All rights reserved.
//

import UIKit

class CreateEventNameController: UIViewController, UITextFieldDelegate {


    @IBOutlet weak var txtName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    //MARK: - Functions
    
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
        
        return true
    }
    
    //MARK: - Actions
    
    @IBAction func btnClose(_ sender: Any) {
        //chiudo il flusso di creazione evento
        self.dismiss(animated: true)
    }
    
    @IBAction func btnNext(_ sender: Any) {
        //passo alla prossima schermata
        self.performSegue(withIdentifier: "GoToNext", sender: self)
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
