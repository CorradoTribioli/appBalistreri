//
//  UIImageViewExtension.swift
//  Dance
//
//  Created by Davide Balistreri on 27/11/20.
//

import UIKit

extension UIImageView {
    
    func setImageWithUrlString(_ urlString: String?) {
        
        // Controllo la validità dei parametri passati alla funzione
        guard let urlString = urlString, let url = URL(string: urlString) else {
            // Parametri non validi
            return
        }
        
        // Rimuovo l'immagine precedentemente impostata
        self.image = nil
        
        // Scarico l'immagine da internet
        DispatchQueue.global().async {
            
            // Controllo la validità dei dati inviati dal server
            let data = try? Data(contentsOf: url)
            
            // Converto i dati in un'immagine
            if let data = data, let immagine = UIImage(data: data) {
                
                // Torno sul thread principale
                DispatchQueue.main.async {
                    
                    // Assegno l'immagine all'imageView
                    self.image = immagine
                }
            }
        }
    }
    
}
