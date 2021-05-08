//
//  WelcomeController.swift
//  Eventi
//
//  Created by iedstudent on 24/04/2021.
//  Copyright © 2021 Larisa Pantazi. All rights reserved.
//

import UIKit

class WelcomeController: UIViewController {
    
    
    //MARK: - Outlets
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnSignup: UIButton!
    
    @IBOutlet weak var containerMain: UIView!
    @IBOutlet weak var containerLogo: UIView!
    @IBOutlet weak var containerButtons: UIView!
    
    
    //MARK: - Setup
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //ui personalizzata
        //arrotondo gli angoli
        btnLogin.layer.cornerRadius = 24
        btnSignup.layer.cornerRadius = 24
        
        /*
         //Aggiungo l'ombra ai pulsanti
         btnLogin.layer.shadowOpacity = 0.5
         btnLogin.layer.shadowRadius = 8
         */
        
        /*aggiungo bordo
         //creo colore personalizzato in RGB
 
        let coloreCustom = UIColor (red: 58/255, green: 58/255, blue: 58/255, alpha: 1)
        //aggiungo un bordo
        btnLogin.layer.borderWidth = 2
        btnLogin.borderColor = coloreCustom.cgColor
         */
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Avvio l'animazione
        performWelcomeAnimation()
    }
    // Funziona che prepara l'animazione di benvenuto
    private func performWelcomeAnimation() {
        //stato iniziale dell'animazione
        containerLogo.alpha = 0
        containerButtons.alpha = 0
        
        //animazione di posizione
        let frameFinale = containerMain.frame
        var frameIniziale = containerMain.frame
        frameIniziale.origin.y += 200
        containerMain.frame = frameIniziale
        
        //animazione posizione
        UIView.animate(withDuration: 2.5) {
            //stato finale dell'animazione
            self.containerMain.frame = frameFinale
        }
        
        //animazione opacità
        UIView.animate(withDuration: 2) {
            //stato finale dell'animazione
            self.containerLogo.alpha = 1
        }
        
        //la stessa animazione di prima ma con un delay
        UIView.animate(withDuration: 1, delay: 1, options: .curveEaseInOut, animations: {
            //stato finale dei pulsanti
            self.containerButtons.alpha = 1
        }, completion: nil)
    }

}

