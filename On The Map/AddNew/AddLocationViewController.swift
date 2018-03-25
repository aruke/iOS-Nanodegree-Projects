//
//  AddLocationViewController.swift
//  On The Map
//
//  Created by Rajanikant Deshmukh on 24/03/18.
//  Copyright © 2018 Rajanikant Deshmukh. All rights reserved.
//

import UIKit
import MapKit

class AddLocationViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var rootContainer: UIStackView!
    @IBOutlet weak var fieldContainer: UIStackView!
    @IBOutlet weak var locationStringInput: UITextField!
    @IBOutlet weak var findOnMapButton: UIButton!
    
    var rootYPosition: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationStringInput.delegate = self
        rootYPosition = rootContainer.frame.origin.y
        findOnMapButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    @IBAction func onFindOnMapClick(_ sender: Any) {
        findOnMap()
    }
    
    func findOnMap() {
        searchLocation()
    }
    
    private func searchLocation() {
        
        let locationString = locationStringInput.text
        
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = locationString
        
        let search = MKLocalSearch(request: request)
        search.start { [weak self] (response, error) in
            if let array = response?.mapItems {
                
                let coordinates = array[0].placemark.coordinate
                let title = array[0].placemark.title
                
                self?.showAddProfileViewController(locationString: title!, lat: coordinates.latitude, lng: coordinates.longitude)
            } else {
                // TODO: Show Error
            }
        }
    }
    
    func showAddProfileViewController(locationString: String, lat: Double, lng: Double) {
        let controllerIdentifier = "AddProfileViewController"
        let addProfileController: AddProfileViewController = self.storyboard?.instantiateViewController(withIdentifier: controllerIdentifier) as! AddProfileViewController
        addProfileController.locationString = locationString
        addProfileController.lat = lat
        addProfileController.lng = lng
        
        self.navigationController?.pushViewController(addProfileController, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    // MARK: TextViewDelegate Methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        findOnMapButton.isEnabled = (textField.text?.count ?? 0 > 0)
        return true
    }
    
    // MARK: Keyboard Methods
    
    func subscribeToKeyboardNotifications() {
        // Use UIKeyboard WillChangeFrame instead of WillShow for supporting multiple keyboards
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: .UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        // Removes all notification observers
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillChange(_ notification:Notification) {
        // Bottom Y point of the stack view
        let safeBottom = self.fieldContainer.frame.maxY + 96
        
        // Top Y point of keyboard
        let keyboardTop = self.view.frame.height - getKeyboardHeight(notification)
        
        let offset = safeBottom - keyboardTop
        
        // If the stackview is completely visible, no need to shift view
        if (offset <= 0) {
            return
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.rootContainer.frame.origin.y = self.rootYPosition - offset
        })
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        // Reset the view to it's original position
        UIView.animate(withDuration: 0.3, animations: {
            self.rootContainer.frame.origin.y = self.rootYPosition
        })
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
}
