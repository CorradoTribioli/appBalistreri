//
//  EventController.swift
//  Eventi
//
//  Created by iedstudent on 19/06/2021.
//  Copyright © 2021 Larisa Pantazi. All rights reserved.
//

import UIKit
import MapKit

class EventController: UIViewController {
    //l'evento da rappresentare su questa schermata
    var eventToShow: Event!
    
    
    //oggetto  di ios usato per chiedere la posizione dell'utente
    private let manager = CLLocationManager()
    
    //MARK: - Outlets
    @IBOutlet weak var btnPurchase: UIButton!
    
    @IBOutlet weak var imageEvent: UIImageView!
    @IBOutlet weak var nameEvent: UILabel!
    @IBOutlet weak var dataEvent: UILabel!
    @IBOutlet weak var descriptionEvent: UITextView!
    
    @IBOutlet weak var btnAuthor: UIButton!
    @IBOutlet weak var authorEvent: UILabel!
    @IBOutlet weak var imageAuthor: UIImageView!
    
    @IBOutlet weak var likeImg: UIImageView!
    @IBOutlet weak var viewImg: UIImageView!
    @IBOutlet weak var commentImg: UIImageView!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var ViewLabel: UILabel!
    @IBOutlet weak var CommentsLabel: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var mapAdress: UILabel!
    
    
    //MARK - Setup

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //UI
        UIHelper.CircleRound(view: self.btnPurchase)
        
        
        //dati dell'evento
        self.nameEvent.text=self.eventToShow.nome
        self.dataEvent.text=self.eventToShow.timestamp
        self.descriptionEvent.text=self.eventToShow.descrizione
        self.imageEvent.setImageWithUrlString(self.eventToShow.cover_url)
        
        //dati dell'autore
        self.authorEvent.text = self.eventToShow.creatore?.nomeCompleto
        self.imageAuthor.setImageWithUrlString(self.eventToShow.creatore?.avatar_url)
        UIHelper.CircleRound(view: self.imageAuthor)
        
        //dati map
        self.mapAdress.text = self.eventToShow.indirizzo
        //metto il pin sulla mappa
        let pin = MapPin()
        pin.title = self.eventToShow.nome
        pin.subtitle = self.eventToShow.indirizzo
        pin.coordinate = CLLocationCoordinate2D(latitude: self.eventToShow.lat ?? 0, longitude: self.eventToShow.lng ?? 0)
        self.mapView.addAnnotation(pin)
        //avvicino la telecamera
        let camera = self.mapView.camera
        camera.altitude = 1000
        camera.centerCoordinate = pin.coordinate
        //mostro la posizione dell'utente
        self.mapView.showsUserLocation = true
        manager.requestWhenInUseAuthorization()
        
        
        //likes comments views
        let views = self.eventToShow.numero_visualizzazioni ?? 0
        self.ViewLabel.text = "\(views)"
        
        let likes = self.eventToShow.numero_like ?? 0
        self.likeLabel.text = "\(likes)"
        
        let comments = self.eventToShow.numero_commenti ?? 0
        self.CommentsLabel.text = "\(comments)"
    
        
        
        
        //compongo la stringa del prezzo
        let price = self.eventToShow.stringaPrezzo
        
        
        //cambio il testo dei pulsanti
        btnPurchase.setTitle(price, for: .normal)
        btnAuthor.setTitle("", for: .normal)
        
        
        
    }
    

    
    //MARK: - Actions

    @IBAction func btnPurchase(_ sender: Any) {
    }
    
    //istanzio la nuova schermata del profilo
    @IBAction func btnAuthor(_ sender: Any) {
        let storyboard = self.storyboard
        let profile = storyboard?.instantiateViewController(withIdentifier: "ProfileController")
        profile?.modalPresentationStyle = .fullScreen
        //self.navigationController?.pushViewController(nextController, animated: true)
    }
}
