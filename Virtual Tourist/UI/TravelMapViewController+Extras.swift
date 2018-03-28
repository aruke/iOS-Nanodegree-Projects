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
}
