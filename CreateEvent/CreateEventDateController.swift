//
//  CreateEventDateController.swift
//  Eventi
//
//  Created by iedstudent on 07/12/21.
//  Copyright © 2021 Larisa Pantazi. All rights reserved.
//

import UIKit

class CreateEventDateController: UIViewController {
    
    var eventToCreate: CreateEvent!

    //MARK: - Outlets
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    //MARK: - Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.datePicker.date = self.eventToCreate.date ?? Date()
        
        //impedisco di creare eventi nel passato
        datePicker.minimumDate = Date()
        
        //impedisco di creare eventi nel futuro
        datePicker.maximumDate = Date()+3000000
    }
    
    private func fillEventToCreate() {
        
        let dataSelezionata = self.datePicker.date
        
        
        let formatter = DateFormatter()
        
        //decido il formato della data che voglio
        formatter.dateFormat = "yyyy-MM-dd' 'HH:mm:SS"
        
        self.eventToCreate.timestamp = formatter.string(from: dataSelezionata)
        
    }
    //MARK: - Actions
    
    @IBAction func btnBack(_ sender: Any) {
        self.fillEventToCreate()
        //torno alla pagina precedente
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnNext(_ sender: Any) {
        //passo alla prossima schermata
        self.fillEventToCreate()
        self.performSegue(withIdentifier: "GoToNext", sender: self)
    }
    
    

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // questta funzione viene richiamata automaticamente dallo storyboard quando si passa
        // da un view controller all'altro
        if let nextController = segue.destination as? CreateEventAddressController {
            // la prossima pagina è quella della data
            
            // gli passo l'evento in fase di creazione
            nextController.eventToCreate = self.eventToCreate
        }
    }


}
