//
//  CreateEventCoverController.swift
//  Eventi
//
//  Created by iedstudent on 07/12/21.
//  Copyright © 2021 Larisa Pantazi. All rights reserved.
//

import UIKit

class CreateEventCoverController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var eventToCreate: CreateEvent!
    
    //MARK: - Outlets
    
    @IBOutlet weak var imgCover: UIImageView!
    @IBOutlet weak var btnChooseCover: UIButton!
    
    //MARK: - Setup

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // carico l'immagine precedentemente selezionata
        self.imgCover.isHidden = (self.eventToCreate.coverToUpload == nil) ? true : false
        self.imgCover.image = self.eventToCreate.coverToUpload
        if(self.eventToCreate.coverToUpload != nil) {
            btnChooseCover.setTitle("Seleziona un'altra foto", for: .normal)
        }
        
        //setup UI
        self.imgCover.layer.cornerRadius = 12
        self.imgCover.clipsToBounds = true
    }
    
    
    
    //MARK: - Actions
    
    @IBAction func btnBack(_ sender: Any) {
        //torno alla pagina precedente
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnNext(_ sender: Any) {
        //passo alla prossima schermata
        if self.eventToCreate.coverToUpload != nil {
            self.performSegue(withIdentifier: "GoToNext", sender: self)
        } else {
            AlertHelper.showSimpleAlert(message: "La cover è obbligatoria", viewController: self)
        }
        
        
    }
    @IBAction func btnChooseCover(_ sender: Any) {
        AlertHelper.showCameraActionSheet(viewController: self) {
            (isCamera) in
            
            //creo il picker di sistema
            let pickerController = UIImagePickerController()
            
            // divento delegate del picker, per ricevere la foto scattata o selezionata dall'utente
            pickerController.delegate = self
            
            // operatore ternario per semplificare un IF
            // se isCamera è true viene preso il valore dopo il "?"
            // altrimenti viene preso il valore dopo i ":"
            pickerController.sourceType = isCamera ? .camera : .photoLibrary
            
            self.present(pickerController, animated: true)
        }
    }
    
    // MARK: - UIImagePickerController delegate
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //l'utente ha annullato la selezione
        // chiudo il controller del picker
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // l'utente ha scelto o scattato una foto
        
        // prendo la foto scelta
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.imgCover.isHidden = false
            self.imgCover.image = image
            
            self.eventToCreate.coverToUpload = image
            
            //cambio il testo del pulsante
            btnChooseCover.setTitle("Seleziona un'altra foto", for: .normal)
        }
        
        // chiudo il controller del picker
        picker.dismiss(animated: true)
    }

    
    // MARK: - Navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // questta funzione viene richiamata automaticamente dallo storyboard quando si passa
         // da un view controller all'altro
         if let nextController = segue.destination as? CreateEventConfirmController {
             // la prossima pagina è quella del confirm
             
             // gli passo l'evento in fase di creazione
             nextController.eventToCreate = self.eventToCreate
         }
     }

}
