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
