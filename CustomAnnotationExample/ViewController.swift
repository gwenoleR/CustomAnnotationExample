//
//  ViewController.swift
//  CustomAnnotationExample
//
//  Created by Gwenole on 24/10/2019.
//  Copyright © 2019 Gwenole. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController  {
    
    var coordinates: [[Double]]!
    var names:[String]!
    var infos:[String]!
    var mores:[String]!
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coordinates = [[48.85672,2.35501],[48.85196,2.33944],[48.85376,2.33953]]
        names = ["First annotation", "Second annotation", "Third annotation"]
        infos = ["Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas id fringilla diam. Quisque risus dolor, lobortis sit amet euismod non, dignissim vitae ligula.", "Donec blandit odio justo, id tincidunt ex convallis in. Integer vel augue id arcu ultricies iaculis at eget orci. Lorem ipsum dolor sit amet, consectetur adipiscing elit.", "Donec blandit odio justo, id tincidunt ex convallis in. Integer vel augue id arcu ultricies iaculis at eget orci. Lorem ipsum dolor sit amet, consectetur adipiscing elit."]
        mores = ["It was the first","It was the second", "It was the third"]
        
        self.mapView.delegate = self //This file is the current delegate, see bottom
        
        let iEnd = coordinates.count-1
        for i in 0...iEnd
        {
            let coordinate = coordinates[i]
            let name = names[i]
            let infos = self.infos[i]
            let more = mores[i]
            
            let point = CustomAnnotation(
                coordinate: CLLocationCoordinate2D(latitude: coordinate[0] , longitude: coordinate[1] ),
                name: name,
                infos: infos,
                more: more)
            
            self.mapView.addAnnotation(point)
        }
        
        // Center the map
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 48.856614, longitude: 2.3522219000000177), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        self.mapView.setRegion(region, animated: true)
    }


}

extension ViewController : MKMapViewDelegate {

    func mapView(_ mapView: MKMapView,
                 didSelect view: MKAnnotationView)
    {
        if view.annotation is MKUserLocation
        {
            // Don't proceed with custom callout
            return
        }
        
        let customAnnotation = view.annotation as! CustomAnnotation
        let views = Bundle.main.loadNibNamed("CustomCalloutView", owner: nil, options: nil)
        let calloutView = views?[0] as! CustomCalloutView
        calloutView.nameLabel.text = customAnnotation.name
        calloutView.infosLabel.text = customAnnotation.infos
        calloutView.moreLabel.text = customAnnotation.more
        
        
        calloutView.center = CGPoint(x: view.bounds.size.width / 2, y: -calloutView.bounds.size.height*0.52)
        view.addSubview(calloutView)
        mapView.setCenter((view.annotation?.coordinate)!, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {

            for subview in view.subviews
            {
                if subview is CustomCalloutView{
                    subview.removeFromSuperview()
                }
            }
    }
}
