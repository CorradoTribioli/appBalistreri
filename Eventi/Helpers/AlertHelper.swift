//
//  AlertHelper.swift
//  Eventi
//
//  Created by iedstudent on 15/05/2021.
//  Copyright © 2021 Larisa Pantazi. All rights reserved.
//
import UIKit
import Foundation
class AlertHelper {
    
    typealias AlertHandler = (() -> Void)
    
    static func showSimpleAlert (title: String? = "Attenzione", message: String? = nil, viewController: UIViewController?, handler: AlertHandler? = nil) {
        let alert = UIAlertController (title: title, message: message, preferredStyle: .alert)
        
        //creo il pulsante OK
        let actionOk = UIAlertAction (title: "OK", style: .cancel) {
            //questa parte di codice viene eseguita in modo asincrono quando l'utente preme questo pulsante
            (action) in
            
            //eseguo l'handler
            handler?()
            
        }
        //aggiungo il pulsante all'alert
        alert.addAction(actionOk)
        //mostro l'alert
        viewController?.present(alert, animated: true)
    }
}
