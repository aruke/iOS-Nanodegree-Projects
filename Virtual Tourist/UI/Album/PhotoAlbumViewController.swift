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
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Set the camera for map
        mapView.centerCoordinate = locationCoordinates
        mapView.region = MKCoordinateRegion(center: locationCoordinates, span: MKCoordinateSpanMake(0.2, 0.2))
        // Add a Pin
        let annotation = MKPointAnnotation()
        annotation.coordinate = locationCoordinates
        mapView.addAnnotation(annotation)
        
        // Set title
        title = locationString
        
        // Setup toolbar
        navigationController?.toolbar.barTintColor = UIColor(named: "PrimaryColor")
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        let deleteButton = UIBarButtonItem(image: UIImage(named: "icon_delete"), style: .plain, target: self, action: #selector(deleteImages))
        deleteButton.tintColor = UIColor.white
        
        let refreshButton = UIBarButtonItem(image: UIImage(named: "icon_refresh"), style: .plain, target: self, action: #selector(refreshImageSet))
        refreshButton.tintColor = UIColor.white
        
        setToolbarItems([spacer, deleteButton, spacer, refreshButton, spacer], animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Show toolbar
        navigationController?.isToolbarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Hide toolbar
        navigationController?.isToolbarHidden = true
    }
    
    @objc func refreshImageSet() {
        
    }
    
    @objc func deleteImages() {
        
    }

    @IBAction func onNewCollectionClicked(_ sender: Any) {
        
    }
}
