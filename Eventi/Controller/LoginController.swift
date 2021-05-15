//
//  LoginController.swift
//  Eventi
//
//  Created by iedstudent on 08/05/2021.
//  Copyright © 2021 Larisa Pantazi. All rights reserved.
//

import UIKit

class LoginController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //arrotondo gli angoli del btn
        UIHelper.CircleRound(view: btnLogin)
        UIHelper.CircleRound(view: containerGoogle)
        UIHelper.CircleRound(view: containerFb)
        UIHelper.CircleRound(view: containerIg)
        
        //Divento delegate delle text field, per essere informato di quello che fa l'utente
        self.textPassword.delegate = self
        self.textUserName.delegate = self

 
    }
    
    //MARK: Textfield delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //questa funzione delegate viene richiamata quando l'utente preme 'invio' dentro a una text field
        
        if textField == self.textUserName {
            // ha premuto invio dal campo username
        
            if textField.text != "" {
                //sposto il focus autmaticamente sul campo della password
                self.textPassword.becomeFirstResponder()
            }
        }
        
        if textField == self.textPassword {
            //ho premuto 'invio' sul campo password
            //richiamo diettamente il button login
            if textField.text != "" {
                //chiudo la tastiera
                textField.resignFirstResponder()
                self.btnLogin()
            }

            
        }
        
        return true
    }
    
    //MARK: - Outlets
    //button accedi
    @IBOutlet weak var btnLogin: UIButton!
    
    //email e password
    @IBOutlet weak var textUserName: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    
    //icone social
    @IBOutlet weak var containerGoogle: UIView!
    @IBOutlet weak var containerFb: UIView!
    @IBOutlet weak var containerIg: UIView!
    
    
    
     //MARK: - Action
    @IBAction func btnLogin(_ sender: Any? = nil) {
        if textUserName.text == "lary" , textPassword.text == "password" {
        goToHome()
        }
        else {
            showInvalidLogicAlert()
        }
    }
    
    private func goToHome() {
        //prendo lo storybord dove risiede l'homeController
            //è lo stesso storyboard di LoginController
        let storyboard = self.storyboard
        
        //istanzio il view controller con Storyboard ID = "HomeController"
        let home = storyboard?.instantiateViewController(withIdentifier: "HomeController")
        
        //presento il view controller
        home?.modalPresentationStyle = .fullScreen
        self.present(home!, animated: true)
    }
    
    private func showInvalidLogicAlert() {
        AlertHelper.showSimpleAlert(message: "Credenziali errate‼️", viewController: self)
    }
    
}
