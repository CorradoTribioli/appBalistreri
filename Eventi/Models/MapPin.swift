//
//  MapPin.swift
//  Eventi
//
//  Created by iedstudent on 03/07/2021.
//  Copyright © 2021 Larisa Pantazi. All rights reserved.
//

import UIKit
import MapKit

class MapPin: NSObject, MKAnnotation {
    
    var title: String?
    var subtitle: String?
    var coordinate = CLLocationCoordinate2D()
}
