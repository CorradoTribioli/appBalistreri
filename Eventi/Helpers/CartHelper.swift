//
//  CartHelper.swift
//  Eventi
//
//  Created by iedstudent on 12/10/21.
//  Copyright © 2021 Larisa Pantazi. All rights reserved.
//

import Foundation
///Questa classe ci aiuta a gestire il carrello in tutta l'app
class CartHelper {
    ///Lista di oggetti attualmente inseriti nel carrello
    static var items: [Event] = []
    
    static var totalPrice: Double {
        // calcolo il costo totale dei biglietti nel carrello
        
        var sommaPrezzi = 0
        
        for item in items {
            sommaPrezzi += item.prezzo ?? 0
        }
        
        // converto il totale in un numero con la virgola
        // e divido per 100 perché il prezzo è espresso in centesimi
        return Double(sommaPrezzi) / 100
    }
    
    /// La stringa da visualizzare per il prezzo totale
    static var totalPriceString: String {
        // 1. Formatto la stringa con due zeri dopo la virgola
        var string = String(format: "%.02f", totalPrice)
        
        // 2. Sostituisco il punto con la virgola
        string = string.replacingOccurrences(of: ".", with: ",")
        
        // 3. Aggiungo il simbolo dell'euro
        return "\(string) €"
    }
    
    static func add (_event: Event) {
        //qui faccio i controlli per evitare di aggiungere lo stesso evento.
    }
}
