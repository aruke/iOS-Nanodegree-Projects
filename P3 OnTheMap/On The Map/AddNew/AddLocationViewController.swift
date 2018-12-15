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
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var findOnMapButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
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
        
        startLoading()
        
        let locationString = locationStringInput.text
        
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = locationString
        
        let search = MKLocalSearch(request: request)
        search.start { [weak self] (response, error) in
            self?.stopLoading()
            if let array = response?.mapItems {
                
                let coordinates = array[0].placemark.coordinate
                let title = array[0].placemark.title
                
                self?.showAddProfileViewController(locationString: title!, lat: coordinates.latitude, lng: coordinates.longitude)
            } else {
                self?.showAlertDialog(title: "Oops!", message: "The location you are seaarching doesn't exist On The Map! Please try with detail addreess.", dismissHandler: { _ in
                    
                })
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
    
    // MARK: View State Methods
    
    func initView() {
        locationStringInput.delegate = self
        indicatorView.isHidden = true
        findOnMapButton.isEnabled = false
    }
    
    func startLoading() {
        indicatorView.isHidden = false
        indicatorView.startAnimating()
        findOnMapButton.isEnabled = false
        locationStringInput.isEnabled = false
        locationStringInput.resignFirstResponder()
    }
    
    func stopLoading() {
        indicatorView.stopAnimating()
        indicatorView.isHidden = true
        findOnMapButton.isEnabled = true
        locationStringInput.isEnabled = true
    }
    
    // MARK: TextViewDelegate Methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        findOnMapButton.isEnabled = (textField.text?.count ?? 0 > 0)
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
            //self.rootContainer.frame.origin.y = self.rootYPosition - offset
            self.view.frame.origin.y = -offset
        })
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        // Reset the view to it's original position
        UIView.animate(withDuration: 0.3, animations: {
            //self.rootContainer.frame.origin.y = self.rootYPosition
            self.view.frame.origin.y = 0
        })
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
}
