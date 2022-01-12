//

//  TrisGameController.swift

//  Eventi

//

//  Created by iedstudent on 21/12/21.

//  Copyright © 2021 Larisa Pantazi. All rights reserved.

//



import UIKit



class TrisGameController: UIViewController {



    //MARK: - Outlets

    

    @IBOutlet weak var uno: UIView!

    @IBOutlet weak var due: UIView!

    @IBOutlet weak var tre: UIView!

    @IBOutlet weak var quattro: UIView!

    @IBOutlet weak var cinque: UIView!

    @IBOutlet weak var sei: UIView!

    @IBOutlet weak var sette: UIView!

    @IBOutlet weak var otto: UIView!

    @IBOutlet weak var nove: UIView!

    

    

    //MARK: - Setup

    override func viewDidLoad() {

        super.viewDidLoad()

        ricomincioGioco()

    }

        //MARK: - Variabili di gioco

        private var numeroPartita = 1

        

    private var mosse: [Bool?] = []

        

        

        

        //MARK: - Inizio gioco

        

        private func ricomincioGioco() {

            //azzero le mosse

            self.mosse = [

                nil, nil, nil,

                nil, nil, nil,

                nil, nil, nil

                ]

            self.aggiornaRiquadri()

        }

    

    private func aggiornaRiquadri() {

        aggiorna(riquadro: uno)

        aggiorna(riquadro: due)

        aggiorna(riquadro: tre)

        aggiorna(riquadro: quattro)

        aggiorna(riquadro: cinque)

        aggiorna(riquadro: sei)

        aggiorna(riquadro: sette)

        aggiorna(riquadro: otto)

        aggiorna(riquadro: nove)

    }

    

    private func aggiorna(riquadro: UIView) {

        //filtro le subview del riguadro

        //lasciando solo le UIImageView

        let imagesViews = riquadro.subviews.filter({$0 is UIImageView})

        let imageView = imagesViews.last as? UIImageView

       

        

        let numeroRiquadro = riquadro.tag

        let mossaEseguita = mossa(riquadro: numeroRiquadro)

        

        if mossaEseguita == true {

            //Giocatore

            imageView?.image = UIImage(systemName:"xmark")

        }

        else if mossaEseguita == false {

            //Computer

            imageView?.image = UIImage(systemName:"circle")

        }

        else {

            //immagine vuota

            imageView?.image = nil

        }

            

    }

    

    @IBAction func riquadroTappato(_ sender: UIButton) {

        // Turno giocatore

        let numeroRiquadro = sender.tag

        

        

        //controllo se può fare la mossa

        if mossa(riquadro: numeroRiquadro) != nil { return }

        

        //Eseguiamo la mossa

        setMossa(riquadro: numeroRiquadro, isGiocatore: true)

        

        aggiornaRiquadri()

        

        if checkPartitaFinita() {

            // interrompo il gioco

            return

        }

        

        

        // TURNO COMPUTER

        //blocchiamo la schermata
        self.view.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {

            [self] in
            
            //sblocchiamo la schermata
            self.view.isUserInteractionEnabled = true
            


            if let mossaComputer = calcolaMossaComputer() {

                setMossa(riquadro: mossaComputer, isGiocatore: false)

                aggiornaRiquadri()

            }

            

            if checkPartitaFinita() {

                // interrompo il gioco

                return

            }



        }

        

    }



    

    //MARK: - Mosse

    ///questa funziona restituisce la mossa al riquadro specificato

    private func mossa(riquadro: Int)-> Bool? {

        //L'aray du mosse parte la 0

        return mosse[riquadro - 1]

    }

    ///funzione per assegnare la mossa

    private func setMossa(riquadro: Int, isGiocatore: Bool) {

        mosse[riquadro - 1] = isGiocatore

    }

    

    private func calcolaMossaComputer() -> Int? {
        
        // intelligenza 4.0
        //calcolo la mossa per far vincere il computer
        if let mossaVincente = calcolaMossaVincente(isGiocatore: false) {
            return mossaVincente
        }
        
        //intelligenza 3.0
        //calcolo la mossa per bloccare la vittoria del giocatore
        if let bloccaMossaVincente = calcolaMossaVincente(isGiocatore: true) {
            return bloccaMossaVincente
        }

        //Intelligenza 2.0

        let riquadroCentrale = 5

        if mossa(riquadro: riquadroCentrale) == nil {

            //mossa al centro

            return riquadroCentrale

        }

        

        repeat {

        //Intelligenza 1.0

        let numeroRandom = Int.random(in: 1...9)

        if mossa(riquadro: numeroRandom) == nil {

            // il riquadro vuoto

            return numeroRandom

        }

        }while checkPartitaFinita() == false

        

        

        //non si possono fare altre mosse

        return nil

    }

    /// Funzione che controlla se la partita è finita (mosse esaurite o vittoria giocatore)

    private func checkPartitaFinita() -> Bool {

        

        if calcolaVincitore() == true {

            AlertHelper.showSimpleAlert(title: "Hai vinto!", viewController: self){

                self.ricomincioGioco()

            }

            

            //partita finita

            return true

        }

        else if calcolaVincitore() == false {

            AlertHelper.showSimpleAlert(title: "Hai perso", message: nil, viewController: self) {

                self.ricomincioGioco()

            }

            

            //partita finita

            return true

        }



        let mosseRimanenti = mosse.filter({$0 == nil})

        

        if mosseRimanenti.count == 0 {

            AlertHelper.showSimpleAlert(title: "Pareggio!", message: nil, viewController: self){

                self.ricomincioGioco()

            }

            

            //partita finita

            return true

        }

        //partita in corso

        return false

    }

    

    //MARK: - Calcolo vittorie

    

    ///lista delle combinazioni per vincere

    let combinazioniVincenti = [

    //orizzontali

    [1, 2, 3],

    [4, 5, 6],

    [7, 8, 9],

    //verticali

    [1, 4, 7],

    [2, 5, 8],

    [3, 6, 9],

    //oblique

    [1, 5, 9],

    [3, 5, 7]

    

    ]

    

    private func calcolaVincitore() -> Bool? {

        //controllo tutte le combinazioni vincenti

        for combinazione in combinazioniVincenti  {

            //prendo le tre mosse della combinazione

            let uno = mossa(riquadro: combinazione[0])

            let due = mossa(riquadro: combinazione[1])

            let tre = mossa(riquadro: combinazione[2])

            

            let mosseFatte = [uno, due, tre]

            

            if mosseFatte.filter({ $0 == true}).count == 3 {

                //il giocatore ha fatto le tre mosse della combinazione quindi ha vinto

                return true

            }

            

            if mosseFatte.filter({ $0 == false}).count == 3 {

                //l'avversario ha fatto le tre mosse della combinazione quindi ha vinto

                return false

                

            }

        }

        

        //Nessuno dei due giocatori ha vinto

        return nil

    }
    
    /// questa funzione calcola qual è la mossa per far vincere (fare un tris) il giocatore specificato.
    private func calcolaMossaVincente(isGiocatore: Bool) -> Int? {
        
        for combinazione in combinazioniVincenti  {

            //prendo le tre mosse della combinazione

            let uno = mossa(riquadro: combinazione[0])

            let due = mossa(riquadro: combinazione[1])

            let tre = mossa(riquadro: combinazione[2])

            

            let mosseFatte = [uno, due, tre]
            
            //controllo se le mosse sono già state tutte fatte
            guard mosseFatte.filter({$0 == nil}).count == 1 else {
                // questa combinazione è già stat completata
                //passo alla prossima combinazione
                continue
            }
            
            let mosseRimanenti = combinazione.filter({
                //prendo la mosse fatta a questo riquadro
                let mossa = mossa(riquadro: $0)
                
                //lascio solo le mosse vuote
                return mossa == nil ||
                // e quelle dell'altro giocatore
                mossa != isGiocatore
            })
            if mosseRimanenti.count == 1 {
                return mosseRimanenti.first!
            }
        }
        
        //nessuna mossa vincente
        return nil
    }

}
