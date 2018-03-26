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

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var newCollectionButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isToolbarHidden = false
    }

    @IBAction func onNewCollectionClicked(_ sender: Any) {
        
    }
}
