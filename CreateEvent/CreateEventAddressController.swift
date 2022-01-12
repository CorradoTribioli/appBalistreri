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

class CreateEventAddressController: UIViewController, UITextFieldDelegate {
    var eventToCreate: CreateEvent!
    
    let locationManager = CLLocationManager()
    
    //MARK: - Outlets
    
    @IBOutlet weak var btnGeoLocation: UIButton!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    //MARK: - Setup

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //chiedo il permesso per accedere alla poszione dell'utente
        self.locationManager.requestWhenInUseAuthorization()
        // mostro il pallino della posizione dell'utente
        self.mapView.showsUserLocation = true
        
        //setup UI
        self.btnGeoLocation.setTitle("", for: .normal)
        self.mapView.layer.cornerRadius = 16
        
        self.txtAddress.delegate = self
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
        if txtAddress.text != "" {
            self.performSegue(withIdentifier: "GoToNext", sender: self)
        } else {
            AlertHelper.showSimpleAlert(message: "L'indirizzo è obbligatorio", viewController: self)
        }
        
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
