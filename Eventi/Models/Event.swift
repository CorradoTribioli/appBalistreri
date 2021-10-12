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

extension Event {
    var stringaPrezzo: String {
        //converto il prezzo da int a string
        let priceCents = self.prezzo ?? 0
        var priceEurosStr = ""
        if priceCents == 0 {
            priceEurosStr = "Acquista Gratis!"
        }
        else {
            let priceEuros = Double(priceCents) / 100
            priceEurosStr = "Acquista a € \(priceEuros)"
        }
        return priceEurosStr
    }
        var stringDataOra: String {
            let formatter = DateFormatter()
            
            //questo è il formato della data come la manda il server
            formatter.dateFormat = "yyyy-MM-dd' 'HH:mm:SS"
            
            //converto la stringa della datain un oggetto "Date"
            let date = formatter.date(from: timestamp ?? "")
            
            //decido il formato della data che voglio
            formatter.dateFormat = "dd/MM/yyyy' ' HH:mm:SS"
            return formatter.string(from: date ?? Date())
        }
}

extension Event : Equatable {
    static func == (lhs: Event, rhs: Event) -> Bool {
        return lhs.id == rhs.id
    }
    
    
}

