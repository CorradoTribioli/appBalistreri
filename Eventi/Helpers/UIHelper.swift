//
//  UIHelper.swift
//  Eventi
//
//  Created by iedstudent on 08/05/2021.
//  Copyright © 2021 Larisa Pantazi. All rights reserved.
//

import UIKit

class UIHelper {
    /// Questa funziona arrotonda gli angoli della view in modo circolare
    static func CircleRound (view: UIView) {
        view.layer.cornerRadius = view.frame.size.height / 2
    }
        
    /// Questa funzione aggiunge un'ombra
    static func addShadow (view:UIView, alpha: Float = 0.5, radius: CGFloat = 8) {
        view.layer.shadowOpacity = alpha
        view.layer.shadowRadius = radius
    }

}
