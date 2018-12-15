//
//  MapViewController.swift
//  On The Map
//
//  Created by Rajanikant Deshmukh on 18/03/18.
//  Copyright © 2018 Rajanikant Deshmukh. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapViewController: StudentLocationViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
    }
    
    override func studentLocationLoaded(error: Errors?) {
        if error != nil {
            showAlertDialog(title: "Error", message: (error)!.rawValue, dismissHandler: nil)
            return
        }
        
        // Set annotations on map
        var annotations = [MKPointAnnotation]()
        for studentLocation in Cache.shared.studentLocations {
            annotations.append(studentLocation.annotation())
        }
        self.mapView.addAnnotations(annotations)
    }
}
