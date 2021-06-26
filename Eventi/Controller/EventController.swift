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
    
    @IBOutlet weak var mapEvent: MKMapView!
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
        
        //likes comments views
        let views = self.eventToShow.numero_visualizzazioni ?? 0
        self.ViewLabel.text = "\(views)"
        
        let likes = self.eventToShow.numero_like ?? 0
        self.likeLabel.text = "\(likes)"
        
        let comments = self.eventToShow.numero_commenti ?? 0
        self.CommentsLabel.text = "\(comments)"
    
        
        
        
        //compongo la stringa del prezzo
        let priceCents = self.eventToShow.prezzo ?? 0
        
        var priceEurosStr = ""
        
        
        if priceCents == 0 {
            priceEurosStr = "Acquista Gratis!"
        }
        else {
            let priceEuros = Double(priceCents) / 100
            priceEurosStr = "Acquista a € \(priceEuros)"
            
        }
        
        
        //cambio il testo dei pulsanti
        btnPurchase.setTitle(priceEurosStr, for: .normal)
        btnAuthor.setTitle("", for: .normal)
    }
    

    
    //MARK: - Actions

    @IBAction func btnPurchase(_ sender: Any) {
    }
    
    //istanzio la nuova schermata del profilo
    @IBAction func btnAuthor(_ sender: Any) {
        
    }
}
