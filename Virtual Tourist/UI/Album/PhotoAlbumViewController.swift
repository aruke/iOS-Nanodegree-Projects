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
    var locationString: String!
    var locationCoordinates: CLLocationCoordinate2D!
    var album: [Photo] = [Photo]()
    
    // Instantiates PhotoAlbumViewController with given parameters.
    class func getInstance(caller: UIViewController, dataController: DataController, locationString: String, locationCoordinates: CLLocationCoordinate2D) -> PhotoAlbumViewController {
        // Instantiate VC from storyboard
        let albumViewController: PhotoAlbumViewController = caller.storyboard?.instantiateViewController(withIdentifier: STORYBOARD_ID) as! PhotoAlbumViewController
        // Set required parameters and return
        albumViewController.dataController = dataController
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
        
        // Setup collection view controller
        self.collectionView.register(UINib(nibName: "PhotoViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotoViewCell")
        
        // Setup toolbar
        navigationController?.toolbar.barTintColor = UIColor(named: "PrimaryColor")
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        refreshButton = UIBarButtonItem(image: UIImage(named: "icon_refresh"), style: .plain, target: self, action: #selector(refreshImageSet))
        refreshButton.tintColor = UIColor.white
        refreshButton.isEnabled = false
        
        setToolbarItems([spacer, refreshButton, spacer], animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Show toolbar
        navigationController?.isToolbarHidden = false

        refreshImageSet(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Hide toolbar
        navigationController?.isToolbarHidden = true
    }
    
    @objc func refreshImageSet(_ forcedRefresh: Bool = false) {
        setViewState(.LOADING_IMAGES)
        // Pass Context and Start loading images
        FlickrApiHandler.shared.loadPhotos(context: dataController.viewContext, latitude: locationCoordinates.latitude, longitude: locationCoordinates.longitude, completion: {
            // TODO: Handle error and show success case
            DispatchQueue.main.async {
                self.setViewState(.IDLE)
                // Fetch data from database
                let fetchRequest: NSFetchRequest<Photo> = Photo.fetchRequest()
                if let results = try? self.dataController.viewContext.fetch(fetchRequest) {
                    self.album.removeAll()
                    self.album.append(contentsOf: results)
                }
                self.collectionView.reloadData()
            }
        })
    }
    
    @objc func deleteImages() {
        
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
            refreshButton.isEnabled = true
            break
        }
    }
}
