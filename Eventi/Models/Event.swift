//
//  Event.swift
//  Eventi
//
//  Created by iedstudent on 12/06/2021.
//  Copyright © 2021 Larisa Pantazi. All rights reserved.
//

import Foundation

class Event : Codable {
    // TODO: Creare la listadegli eventi sulla Home dell'app
   var id: Int?
   var nome: String?
   var descrizione: String?
   var timestamp: String?
   var cover_url: String?
   var prezzo: Int?
   var indirizzo: String?
   var lat: Double?
   var lng: Double?
   var numero_visualizzazioni: Int?
   var numero_commenti: Int?
   var numero_like: Int?
   var creatore: User?
}
