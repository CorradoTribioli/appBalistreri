//
//  CreateEventAddressController.swift
//  Eventi
//
//  Created by iedstudent on 07/12/21.
//  Copyright © 2021 Larisa Pantazi. All rights reserved.
//

import UIKit

//carico le librerie della mappa:
import MapKit

class CreateEventAddressController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var btnGeoLocation: UIButton!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    //MARK: - Setup

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //setup UI
        self.btnGeoLocation.setTitle("", for: .normal)
        self.mapView.layer.cornerRadius = 16
    }
    
    //MARK: - Actions
    
    @IBAction func btnGeoLocation(_ sender: Any) {
        
    }
    
    @IBAction func btnBack(_ sender: Any) {
        //torno alla pagina precedente
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnNext(_ sender: Any) {
        //passo alla prossima schermata
        self.performSegue(withIdentifier: "GoToNext", sender: self)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
