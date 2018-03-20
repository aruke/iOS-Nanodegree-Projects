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

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        ParseHandler.shared.loadStudentLocations(limit: 0, skip: 0, onComplete: {error , studentLocations in
            DispatchQueue.main.async(execute: {
                self.studentLocationLoaded(error: error, studentLocations: studentLocations)
            })
        })
    }
    
    func studentLocationLoaded(error: Error?, studentLocations: [StudentLocation]?) {
        if error != nil {
            // TODO Show alert
            return
        }
        
        var annotations = [MKPointAnnotation]()
        
        for studentLocation in studentLocations! {
            annotations.append(studentLocation.annotation())
        }
        
        self.mapView.addAnnotations(annotations)
    }
}
