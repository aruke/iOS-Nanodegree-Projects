//
//  TravelMapViewController+Extras.swift
//  Virtual Tourist
//
//  Created by Rajanikant Deshmukh on 28/03/18.
//  Copyright © 2018 Rajanikant Deshmukh. All rights reserved.
//

import Foundation
import UIKit
import MapKit

extension TravelMapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        // This will save the Map's camera state when ever it's changed.
        // Specifically it handles the situation when user presses Home button and
        // viewWillDisappear is not called
        MapViewDefaults.saveDefaults(toSaveMapView: mapView)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }  else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            // Open AlbumViewController
            let annotation = view.annotation
            let locationString = annotation?.title
            let locationCoordinate = annotation?.coordinate
            
            let albumViewController = PhotoAlbumViewController.getInstance(caller: self, locationString: locationString!!, locationCoordinates: locationCoordinate!)
            navigationController?.pushViewController(albumViewController, animated: true)
        }
    }
}
