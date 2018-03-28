//
//  PhotoAlbumViewController.swift
//  Virtual Tourist
//
//  Created by Rajanikant Deshmukh on 26/03/18.
//  Copyright © 2018 Rajanikant Deshmukh. All rights reserved.
//

import UIKit
import MapKit

class PhotoAlbumViewController: UIViewController {
    
    static let STORYBOARD_ID = "PhotoAlbumViewController"

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var newCollectionButton: UIBarButtonItem!
    
    var locationString: String!
    var locationCoordinates: CLLocationCoordinate2D!
    
    /// Instantiates PhotoAlbumViewController with given parameters.
    ///
    /// - Parameters:
    ///   - caller: Parent UIViewController
    ///   - locationString: Location for Photo Album
    ///   - locationCoordinates: Location Coordinates for Photo Album
    /// - Returns: Instance of PhotoAlbumViewController
    class func getInstance(caller: UIViewController, locationString: String, locationCoordinates: CLLocationCoordinate2D) -> PhotoAlbumViewController {
        // Instantiate VC from storyboard
        let albumViewController: PhotoAlbumViewController = caller.storyboard?.instantiateViewController(withIdentifier: STORYBOARD_ID) as! PhotoAlbumViewController
        // Set required parameters and return
        albumViewController.locationString = locationString
        albumViewController.locationCoordinates = locationCoordinates
        return albumViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isToolbarHidden = false
        
        // Set the camera for map
        mapView.centerCoordinate = locationCoordinates
        mapView.region = MKCoordinateRegion(center: locationCoordinates, span: MKCoordinateSpanMake(0.2, 0.2))
        // Add a Pin
        let annotation = MKPointAnnotation()
        annotation.coordinate = locationCoordinates
        mapView.addAnnotation(annotation)
        
        // Set title
        title = locationString
    }

    @IBAction func onNewCollectionClicked(_ sender: Any) {
        
    }
}
