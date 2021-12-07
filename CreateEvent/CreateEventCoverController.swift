//
//  CreateEventCoverController.swift
//  Eventi
//
//  Created by iedstudent on 07/12/21.
//  Copyright © 2021 Larisa Pantazi. All rights reserved.
//

import UIKit

class CreateEventCoverController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var imgCover: UIImageView!
    
    //MARK: - Setup

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //setup UI
        
        self.imgCover.isHidden = true
    }
    
    
    
    //MARK: - Actions
    
    @IBAction func btnBack(_ sender: Any) {
        //torno alla pagina precedente
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnNext(_ sender: Any) {
        
    }
    @IBAction func btnChooseCover(_ sender: Any) {
        
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
