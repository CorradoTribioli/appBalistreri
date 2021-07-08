//
//  HomeController.swift
//  Eventi
//
//  Created by iedstudent on 15/05/2021.
//  Copyright © 2021 Larisa Pantazi. All rights reserved.
//

import UIKit

class HomeController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    // gli eventi da mostrare su questa pagina
    var eventsToShow: [Event] = []
    
    //MARK: - Outlet
    @IBOutlet weak var WelcomeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nome = LoginHelper.loggedUser?.nome ?? ""
        self.WelcomeLabel.text = "Benvenuto \(nome)"
        
        //Setup TableView
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        //aggiorno gli eventi da visualizzare
        self.updateEvents()
    }
    
    //MARK: - Funzioni
    private func updateEvents() {
        //l'indirizzo dell'API da richiamare
        let url = "https://edu.davidebalistreri.it/app/api/eventi.php"
        
        DBNetworking.jsonGet(url: url, authToken: nil, parameters: nil) {
            //questa parte di codice viene eseguita in modo asincrono non appena arriva la risposta del server. l'oggetto 'response' contiene proprio i dati inviati dal server
            (response) in
            if response.success {
                //richiesta riuscita
                
                //mi aspetto che il server abbia inviato un dictioary
                if let dictionary = response.data as? DBDictionary {
                    //prendo l'oggetto 'data' che è un array
                    if let data = dictionary["data"] as? DBArray {
                        
                        //riconverto l'aray in un oggetto JSON
                        let json = try? JSONSerialization.data(withJSONObject: data, options: [])
                        
                        //con un oggetto JSON di tipo  "Data" possiamo ora convertire automaticamente e ottenere una lista di oggetti event
                        let events = try? JSONDecoder().decode([Event].self, from: json ?? Data())
                        //salvo gli eventi scaricati su una variabile globale
                        //devo fornire un valore di backup "?? []" perché la conversione automatica del JSON potrebbe non funzionare
                        self.eventsToShow = events ?? []
                        
                        //ricarico la tabllevieew con i nuovi eventi
                        self.tableView.reloadData()
                    }
                }
            }
                
                
                
            else {
                //Mostro l'alert di errore attraverso la nostra classe AlertHelper
                AlertHelper.showSimpleAlert(message: "Si è verificato un errore", viewController: self)
            }
        }
    }

    //MARK: - Tableview delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.eventsToShow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //prendo la cella prototipata sullo storyboard
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! EventCell
        
        //prendo l'evento da rappresentare in questa cella
        let eventToShow = eventsToShow[indexPath.row]
        
        //configuro la UI della cella
        cell.labelNomeEvento.text = eventToShow.nome
        cell.labelIndirizzo.text = eventToShow.stringaPrezzo
        cell.labelPrezzo.text = eventToShow.stringaPrezzo
        cell.labelData.text = eventToShow.stringDataOra
        cell.imgEvent.setImageWithUrlString(eventToShow.cover_url)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //questa funzione viene richiamata automaricamente dalla table view
        //quando l'utente seleziona una cella
        
        //istanzio la nuova schermata di dettaglio  dell'evento
        let nextController = self.storyboard?.instantiateViewController(withIdentifier: "EventController") as! EventController
        
        //pendo l'evento associalo alla cella selezionata
        let event = self.eventsToShow[indexPath.row]
        
        //lo passo alla schermata del dettaglio
        nextController.eventToShow = event
        
        //nascondo la tab bar
        nextController.hidesBottomBarWhenPushed = true
        //faccio il push del view controller
        self.navigationController?.pushViewController(nextController, animated: true)
    }

}
