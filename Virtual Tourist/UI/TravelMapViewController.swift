//
//  TravelMapViewController.swift
//  Virtual Tourist
//
//  Created by Rajanikant Deshmukh on 22/03/18.
//  Copyright © 2018 Rajanikant Deshmukh. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class TravelMapViewController: UIViewController {

    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var mapView: MKMapView!
    
    var dataController: DataController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set MKMapView Delegate
        mapView.delegate = self
        
        // Set LongPressListener for pins on the map
        let longPressGestureRecogniser = UILongPressGestureRecognizer(target: self, action: #selector(onLongPressed(sender:)))
        mapView.addGestureRecognizer(longPressGestureRecogniser)
        
        // Fetch data from database
        let fetchRequest: NSFetchRequest<Place> = Place.fetchRequest()
        if let results = try? dataController.viewContext.fetch(fetchRequest) {
            for place in results {
                mapView.addAnnotation(place.getAnnotation())
            }
        }
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
        let touchLocation = CLLocation(latitude: touchCoordinates.latitude, longitude: touchCoordinates.longitude)
        
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(touchLocation){
            [weak self] placemarks, error in
            if let placemark = placemarks?.first {
                
                if self == nil {
                    return
                }
                
                let place = Place(context: self!.dataController.viewContext)
                place.locationString = "\(placemark.name ?? ""), \(placemark.locality ?? "")"
                place.latitude = touchCoordinates.latitude
                place.longitude = touchCoordinates.longitude
                
                do {
                    // If data is saved, create annotation and add to MapView
                    try self!.dataController.viewContext.save()
                    self!.mapView.addAnnotation(place.getAnnotation())
                } catch {
                    // Show database error
                    self!.showAlertDialog(title: "Error", message: "Local database error.", dismissHandler: nil)
                }

            } else {
                // Show Geocoding error
                self?.showAlertDialog(title: "Error", message: "No address found for the dropped pin. Try pinning again.", dismissHandler: nil)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Save the camera position when view is about to disappear
        MapViewDefaults.saveDefaults(toSaveMapView: mapView)
    }
}

