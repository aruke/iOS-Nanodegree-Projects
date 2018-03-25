//
//  AddProfileViewController.swift
//  On The Map
//
//  Created by Rajanikant Deshmukh on 24/03/18.
//  Copyright © 2018 Rajanikant Deshmukh. All rights reserved.
//

import UIKit
import MapKit

class AddProfileViewController: UIViewController, UITextFieldDelegate {

    var locationString: String?
    var lat: Double?
    var lng: Double?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var profileLinkInput: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addPinButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userInfo = Cache.shared.userInfo
        nameLabel.text = "\(userInfo?.firstName ?? "") \(userInfo?.lastName ?? "")"
        locationLabel.text = locationString
        
        profileLinkInput.delegate = self
        
        addPinButton.isEnabled = false
        
        let annotation = MKPointAnnotation()
        annotation.coordinate.latitude = lat!
        annotation.coordinate.longitude = lng!
        mapView.addAnnotation(annotation)
        mapView.centerCoordinate = annotation.coordinate
        mapView.region = MKCoordinateRegion(center: annotation.coordinate, span: MKCoordinateSpan(latitudeDelta: 3, longitudeDelta: 3))
    }

    @IBAction func addPinButtonClick(_ sender: Any) {
        let mediaUrl = profileLinkInput.text
        ParseHandler.shared.postStudentLocation(locationString: locationString!, mediaUrl: mediaUrl!, lat: lat!, lng: lng!)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        addPinButton.isEnabled = ((profileLinkInput.text?.count ?? 0) > 0)
        return true
    }
}
