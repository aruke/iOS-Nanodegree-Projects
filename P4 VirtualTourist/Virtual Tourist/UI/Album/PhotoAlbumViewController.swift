//
//  PhotoAlbumViewController.swift
//  Virtual Tourist
//
//  Created by Rajanikant Deshmukh on 26/03/18.
//  Copyright © 2018 Rajanikant Deshmukh. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class PhotoAlbumViewController: UIViewController {
    
    static let STORYBOARD_ID = "PhotoAlbumViewController"

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    var refreshButton: UIBarButtonItem!
    
    var dataController: DataController!
    var place: Place!
    var album: [Photo] = [Photo]()
    var loadedImageCount: Int!
    
    let numberOfItems = 3
    let margin : CGFloat = 8
    let internalSpacing : CGFloat = 4
    
    // Instantiates PhotoAlbumViewController with given parameters.
    class func getInstance(caller: UIViewController, dataController: DataController, place: Place) -> PhotoAlbumViewController {
        // Instantiate VC from storyboard
        let albumViewController: PhotoAlbumViewController = caller.storyboard?.instantiateViewController(withIdentifier: STORYBOARD_ID) as! PhotoAlbumViewController
        // Set required parameters and return
        albumViewController.dataController = dataController
        albumViewController.place = place
        return albumViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Set the camera for map
        let locationCoordinates = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
        mapView.centerCoordinate = locationCoordinates
        mapView.region = MKCoordinateRegion(center: locationCoordinates, span: MKCoordinateSpanMake(0.2, 0.2))
        // Add a Pin
        let annotation = MKPointAnnotation()
        annotation.coordinate = locationCoordinates
        mapView.addAnnotation(annotation)
        
        // Set title
        title = place.locationString
        
        // Setup collection view controller
        self.collectionView.register(UINib(nibName: "PhotoViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotoViewCell")
        
        // Setup toolbar
        navigationController?.toolbar.barTintColor = UIColor(named: "PrimaryColor")
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        refreshButton = UIBarButtonItem(image: UIImage(named: "icon_refresh"), style: .plain, target: self, action: #selector(forceRefreshImageSet))
        refreshButton.tintColor = UIColor.white
        refreshButton.isEnabled = false
        
        setToolbarItems([spacer, refreshButton, spacer], animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Show toolbar
        navigationController?.isToolbarHidden = false
        if !refreshImageSet() {
            forceRefreshImageSet()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Hide toolbar
        navigationController?.isToolbarHidden = true
        // Save data
        do {
            try dataController.viewContext.save()
        } catch {
            print("Data saving failed")
        }
    }
    
    @objc func forceRefreshImageSet() {
        setViewState(.LOADING_IMAGES)
        // Pass Context and Start loading images
        FlickrApiHandler.shared.loadPhotos(context: dataController.viewContext, place: place, completion: { error in
            // Handle error and show success case
            DispatchQueue.main.async {
                if error != nil {
                    self.showAlertDialog(title: "Error", message: (error!.rawValue), dismissHandler: nil)
                    return
                }
                self.setViewState(.IDLE)
                self.refreshImageSet()
            }
        })
    }
    
    func refreshImageSet() -> Bool {
        let photoSet: NSSet? = place.photos
        if photoSet != nil && photoSet?.count ?? 0 > 0 {
            album = Array(photoSet!) as! [Photo]
            loadedImageCount = 0
            self.collectionView.reloadData()
            self.setViewState(.IDLE)
            return true
        }
        return false
    }
    
    // MARK: View States
    
    enum ViewState {
        case LOADING_IMAGES
        case IDLE
    }
    
    func setViewState(_ viewState: ViewState) {
        
        switch viewState {
        case .LOADING_IMAGES:
            mapView.alpha = 0.5
            collectionView.isHidden = true
            indicatorView.isHidden = false
            indicatorView.startAnimating()
            refreshButton.isEnabled = false
            break
        case .IDLE:
            mapView.alpha = 1.0
            collectionView.isHidden = false
            indicatorView.isHidden = true
            indicatorView.stopAnimating()
            refreshButton.isEnabled = false
            break
        }
    }
}
