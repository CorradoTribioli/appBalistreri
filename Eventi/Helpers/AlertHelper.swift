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
    static func showSimpleAlert (title: String? = "Attenzione", message: String? = nil, viewController: UIViewController?) {
        let alert = UIAlertController (title: title, message: message, preferredStyle: .alert)
        
        //creo il pulsante OK
        let actionOk = UIAlertAction (title: "OK", style: .cancel)
        //aggiungo il pulsante all'alert
        alert.addAction(actionOk)
        //mostro l'alert
        viewController?.present(alert, animated: true)
    }
}
