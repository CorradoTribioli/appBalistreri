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

        //configuro il tap recognizer
        self.tapRecognizer.addTarget(self, action: #selector(closeKeyboard))
        self.view.addGestureRecognizer(self.tapRecognizer)
    }

    
    //impostazioni per spostare il mainContainer
    var frameIniziale = CGRect.zero
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //memorizzo il frame iniziale del containeMain per spostare poi la tastiera
        self.frameIniziale = self.containerMainLogin.frame
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
    
    
    
    //riconosce le gesture per poter chiedere la tastiera liccando fuori dai campoi di testo
    var tapRecognizer = UITapGestureRecognizer()
    
    
    
    
    
    //MARK: - Outlets
    //button accedi
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var containerMainLogin: UIView!
    
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
    
    
    //MARK: - Private Function
    
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
    
    
    // allert credenziali errate
    private func showInvalidLogicAlert() {
        AlertHelper.showSimpleAlert(message: "Credenziali errate‼️", viewController: self)
    }
    
    
    
    //funzione mainContainer che si alza
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //sposto la view principale verso l'alto con animazione
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut, .allowUserInteraction], animations: {
             self.containerMainLogin.frame.origin.y = self.frameIniziale.origin.y - 170
        }, completion: nil)
       
    }
    
    //funzione mainContainer che si abbassa
    func textFieldDidEndEditing(_ textField: UITextField) {
        //sposto la view principale nel punto d'origine con l'animazione
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut, .allowUserInteraction], animations: {
            self.containerMainLogin.frame.origin.y = self.frameIniziale.origin.y
        }, completion: nil)
    }

    
    //tab ovunque per chiudere la tastiera
    @objc private func closeKeyboard() {
        self.view.endEditing(true)
    }
    
    

}
