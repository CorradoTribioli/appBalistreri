//
//  CreateEventAddressController.swift
//  Eventi
//
//  Created by iedstudent on 07/12/21.
//  Copyright © 2021 Larisa Pantazi. All rights reserved.
//

import UIKit

//carico le librerie della mappa:
import MapKit

class CreateEventAddressController: UIViewController {
    var eventToCreate: CreateEvent!

    
    //MARK: - Outlets
    
    @IBOutlet weak var btnGeoLocation: UIButton!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    //MARK: - Setup

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //setup UI
        self.btnGeoLocation.setTitle("", for: .normal)
        self.mapView.layer.cornerRadius = 16
    }
    
    //MARK: - Actions
    
    @IBAction func btnGeoLocation(_ sender: Any) {
        
    }
    
    @IBAction func btnBack(_ sender: Any) {
        //torno alla pagina precedente
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnNext(_ sender: Any) {
        //passo alla prossima schermata
        self.performSegue(withIdentifier: "GoToNext", sender: self)
    }
    

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // questta funzione viene richiamata automaticamente dallo storyboard quando si passa
        // da un view controller all'altro
        if let nextController = segue.destination as? CreateEventCoverController {
            // la prossima pagina è quella della data
            
            // gli passo l'evento in fase di creazione
            nextController.eventToCreate = self.eventToCreate
        }
    }

}
