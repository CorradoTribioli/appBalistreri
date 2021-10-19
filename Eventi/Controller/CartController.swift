//
//  CartControllerViewController.swift
//  Eventi
//
//  Created by iedstudent on 12/10/21.
//  Copyright © 2021 Larisa Pantazi. All rights reserved.
//

import UIKit


class CartController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
//MARK: - Outlets
    
    @IBOutlet weak var lblItemsCount: UILabel!
    @IBOutlet weak var lblTotalPrice: UILabel!
    
    /*@IBOutlet weak var btnClose: UIBarButtonItem!
    @IBOutlet weak var btnNext: UIBarButtonItem!
    @IBOutlet weak var btnClearCart: UIButton!*/
    
    @IBOutlet weak var tableView: UITableView!
 
    //MARK: - Setup
    override func viewDidLoad() {
        super.viewDidLoad()

        //imposto il delegate della table view
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.updateController()
    }
    
    /// questa funzione aggiorna la pagina
    private func updateController() {
        // Aggiorno il numero di biglietti
        self.lblItemsCount.text = "\(CartHelper.items.count)"
        // Aggiorno il costo totale
        self.lblTotalPrice.text = CartHelper.totalPriceString
        
        // Ricarico la tabella
        self.tableView.reloadData()
    }
    
//MARK: - Actions
    
    @IBAction func btnClose(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func btnNext(_ sender: Any) {
    }
    @IBAction func btnClearCart(_ sender: Any) {
        // 1. chiedere la conferma dell'utente
        
        // 2. Svuotare il carrello
        CartHelper.items = [] // questo è un array vuoto
        
        // 3. Ricaricare la pagina
        self.updateController()
        
    }

// MARK: - TableViewDelegate


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CartHelper.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //riutilizo una cella della table view con identifier "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let event = CartHelper.items[indexPath.row]
        cell.textLabel?.text = event.nome
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // questa funzione viene richiamata quando l'utente preme sullo swipe-to-delete
        
        // 1. cancello l'evento dal carrello
        CartHelper.items.remove(at: indexPath.row)
        
        // 2. Ricarico la pagina
        self.updateController()
        
    }
    
}
