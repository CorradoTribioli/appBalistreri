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
    
    typealias CameraActionSheetHandler = ((_ isCamera: Bool) -> Void)
    
    /// questa funzione mostra un alert con più pulsanti
    static func showCameraActionSheet(title: String? = "Attenzione", message: String? = "Da dove vuoi caricare la foto?", viewController: UIViewController?, handler: CameraActionSheetHandler?) {
        
        
        let actionSheet = UIAlertController (title: title, message: message, preferredStyle: .actionSheet)
        let actionCamera = UIAlertAction (title: "Fotocamera", style: .default){
            (action) in
            
            #if targetEnvironment(simulator)
            // sul simulatore non c'è la fotocamera (e l'app crasha)
            AlertHelper.showSimpleAlert(title: "Attenzione", message: "Sul simulatore non è possibile usare la fotocamera", viewController: viewController)
            return
            #endif
        
            // l'utente ha scelto la fotocamera (== true)
            handler?(true)
        }
        
        actionSheet.addAction(actionCamera)
        
        // creo il pulsante della galleria
        let actionGalleria = UIAlertAction (title: "Galleria", style: .default){
            (action) in
        
            // l'utente ha scelto la galleria (== false)
            handler?(false)
        }
        
        actionSheet.addAction(actionGalleria)
        
        // creo il pulsante per annullare l'azione
        let actionAnnulla = UIAlertAction(title: "Annulla", style: .cancel) {
            (action) in
            
            // proviamo a non scrivere niente
        }
        
        actionSheet.addAction(actionAnnulla)
        
        // mostro l'action sheet
        viewController?.present(actionSheet, animated: true)
        
    }
}
