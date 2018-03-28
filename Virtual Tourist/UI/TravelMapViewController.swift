//
//  TravelMapViewController.swift
//  Virtual Tourist
//
//  Created by Rajanikant Deshmukh on 22/03/18.
//  Copyright © 2018 Rajanikant Deshmukh. All rights reserved.
//

import UIKit
import MapKit

class TravelMapViewController: UIViewController {

    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set MKMapView Delegate
        mapView.delegate = self
        
        // Set LongPressListener for pins on the map
        let longPressGestureRecogniser = UILongPressGestureRecognizer(target: self, action: #selector(onLongPressed(sender:)))
        mapView.addGestureRecognizer(longPressGestureRecogniser)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Set the camera to previous position
        MapViewDefaults.setDefaults(toSetMapView: mapView)
    }
    
    @IBAction func onEditClicked(_ sender: Any) {
    }
    
    @objc func onLongPressed(sender: UILongPressGestureRecognizer) {
        // If the gesture is in process, return
        if sender.state != .ended {
            return
        }
        
        // Get LocationCoordinates from touched point
        let touchPoint: CGPoint = sender.location(in: mapView)
        let touchCoordinates: CLLocationCoordinate2D = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        
        // Create annotation
        let annotation = MKPointAnnotation()
        annotation.coordinate = touchCoordinates
        
        // Add annotation to MapView
        mapView.addAnnotation(annotation)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Save the camera position when view is about to disappear
        MapViewDefaults.saveDefaults(toSaveMapView: mapView)
    }
}

