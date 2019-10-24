//
//  CustomAnnotation.swift
//  CustomAnnotationExample
//
//  Created by Gwenole on 24/10/2019.
//  Copyright © 2019 Gwenole. All rights reserved.
//

import MapKit

class CustomAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var name: String
    var infos: String
    var more: String
    
    init(coordinate: CLLocationCoordinate2D, name:String, infos:String, more:String) {
        self.coordinate = coordinate
        self.name = name
        self.infos = infos
        self.more = more
    }
}
