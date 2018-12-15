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
import CoreData

extension TravelMapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        // This will save the Map's camera state when ever it's changed.
        // Specifically it handles the situation when user presses Home button and
        // viewWillDisappear is not called
        MapViewDefaults.saveDefaults(toSaveMapView: mapView)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if !(annotation is MKPointAnnotation) {
            return nil
        }
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }  else {
            pinView!.annotation = annotation
        }
        
        if editModeOn {
        } else {
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("Annotation Seleacted")
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control != view.rightCalloutAccessoryView {
            return
        }
        
        // Get data form anntation
        let annotation = view.annotation
        let locationString = annotation?.title
        
        if editModeOn {
            // Delete pin and Place
            if let place = getPlace(locationString!!) {
                dataController.viewContext.delete(place)
                do {
                    // If data is saved, create annotation and add to MapView
                    try self.dataController.viewContext.save()
                    mapView.removeAnnotation(annotation!)
                } catch {
                    // Show database error
                    self.showAlertDialog(title: "Error", message: "Local database error.", dismissHandler: nil)
                }
                return
            }
        }
        
        // Open AlbumViewController
        if let place = getPlace(locationString!!) {
        let albumViewController = PhotoAlbumViewController.getInstance(caller: self, dataController: dataController, place: place)
        navigationController?.pushViewController(albumViewController, animated: true)
        }
    }
    
    private func getPlace(_ locationString: String) -> Place? {
        let fetchRequest: NSFetchRequest<Place> = Place.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "locationString = %@", locationString)
        if let results = try? dataController.viewContext.fetch(fetchRequest) {
            if results.count <= 0 {
                // No object found
                return nil
            }
            
            let place = results[0]
            return place
        }
        
        return nil
    }
    
    func refreshMapAnnoatation() {
        let annotations = mapView.annotations
        editButton.isEnabled = annotations.count > 0
        mapView.removeAnnotations(annotations)
        mapView.addAnnotations(annotations)
    }
}
