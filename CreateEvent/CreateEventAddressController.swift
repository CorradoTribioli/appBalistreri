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
    
    //tap recognizer per recuperare le coordinate quando si tocca la mappa
    let tapRecognizer = UITapGestureRecognizer()
    
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
        
        // Tap recognizer mappa
        self.tapRecognizer.addTarget(self, action: #selector(mapTap))
        self.mapView.addGestureRecognizer(self.tapRecognizer)
        
        // carico il pin e l'indirizzo precedentemente selezionati
        self.txtAddress.text = self.eventToCreate.indirizzo
        if let latitude = self.eventToCreate.lat, let longitude = self.eventToCreate.lng {
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            self.setPin(coordinate: coordinate)
        }
        
        
    }
    
    //MARK: - Actions
    
    @IBAction func btnGeoLocation(_ sender: Any) {
        let indirizzo = self.txtAddress.text
        guard indirizzo?.isEmpty == false else {
            // indirizzo vuoto, non continuo l'esecuzione del codice
            return
        }
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(indirizzo ?? "") {
            (placemarks: [CLPlacemark]?, error: Error?) in
            
            guard let firstPlacemark = placemarks?.first else{
                // non ha trovato nessun indirizzo
                return
            }
            
            // indirizzo trovato, prendo le coordinate
            guard let coordinate = firstPlacemark.location?.coordinate else {
                // l'indirizzo non ga coordinate, non continuo
                return
            }
            
            // aggiungo un pin all'indirizzo specificato
            self.setPin(coordinate: coordinate)
            
            // aggiorno l'indirizzo dell'evento
            self.setAddress(coordinate: coordinate)
        }
    }
    
    @objc private func mapTap() {
        // prendo il punto X e Y toccato sulla mappa
        let tapLocation = self.tapRecognizer.location(in: self.mapView)
        
        //converto il punto in coordinate geografiche
        let coordinate = self.mapView.convert(tapLocation, toCoordinateFrom: self.mapView)
        
        setPin(coordinate: coordinate)
        setAddress(coordinate: coordinate)
        
    }
    
    // MARK: - Private Functions
    
    private func setPin(coordinate: CLLocationCoordinate2D){
        //rimuovo tutti i pin dalla mappa
        self.mapView.removeAnnotations(self.mapView.annotations)
        
        //metto il pin sulla mappa
        let pin = MapPin()
        pin.title = eventToCreate.nome
        pin.subtitle = eventToCreate.descrizione
        pin.coordinate = CLLocationCoordinate2D(latitude: coordinate.latitude ?? 0, longitude: coordinate.longitude ?? 0)
        self.mapView.addAnnotation(pin)
        
        // aggiorno le coordinate dell'evento in fase di creazione
        self.eventToCreate.lat = coordinate.latitude
        self.eventToCreate.lng = coordinate.longitude
        
        //avvicino la telecamera
        /*let camera = MKMapCamera()
        camera.altitude = 1000
        camera.centerCoordinate = pin.coordinate
        self.mapView.setCamera(camera, animated: true)
        */
        // modo #2
        self.mapView.setCenter(coordinate, animated: true)
    }
    
    private func setAddress(coordinate: CLLocationCoordinate2D) {
        // oggetto di CoreLocation che permette di convertire coordinate e indirizzi
        let geocoder = CLGeocoder()
        
        // converto il CLLocationCoordinate2D in un oggetto CLLocation
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        geocoder.reverseGeocodeLocation(location) {
            (placemarks, error) in
            
            // solitamente il geocoding restituisce un array con un solo risultato
            guard let firstPlacemark = placemarks?.first else{
                // non ha trovato nessun indirizzo
                return
            }
            // indirizzo trovato, compongo la stringa
            var components: [String] = []
            
            // ESEMPIO:     Via Alcamo, 11, 00182, Roma, Italia
            
            // aggiungo la via solo se è riuscito a recuperarla
            if let via = firstPlacemark.thoroughfare {
                components.append(via)
            }
            if let civico = firstPlacemark.subThoroughfare {
                components.append(civico)
            }
            if let cap = firstPlacemark.postalCode {
                components.append(cap)
            }
            if let citta = firstPlacemark.locality {
                components.append(citta)
            }
            if let stato = firstPlacemark.country {
                components.append(stato)
            }
            
            // concateno i componenti in una stringa unica
            let address = components.joined(separator: ", ")
            
            // aggiorno il campo di testo dell'indirizzo
            self.txtAddress.text = address
            
            // aggiorno l'evento in fase di creazione
            self.eventToCreate.indirizzo = address
        }
        
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
            // la prossima pagina è quella della cover
            
            // gli passo l'evento in fase di creazione
            nextController.eventToCreate = self.eventToCreate
        }
    }

}
