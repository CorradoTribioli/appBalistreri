//
//  EventCell.swift
//  Eventi
//
//  Created by iedstudent on 03/07/2021.
//  Copyright © 2021 Larisa Pantazi. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var labelNomeEvento: UILabel!
    @IBOutlet weak var labelIndirizzo: UILabel!
    @IBOutlet weak var labelData: UILabel!
    @IBOutlet weak var labelPrezzo: UILabel!
    @IBOutlet weak var imgEvent: UIImageView!
    
    
    // MARK: - Setup
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    UIHelper.CircleRound(view: self.imgEvent)
        contentView.backgroundColor = UIColor.init(red: 0.14, green: 0.14, blue: 0.14, alpha: 1)
        //colore cell selected
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.black
        selectedBackgroundView = bgColorView
    }

    
}
