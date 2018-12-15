//
//  Extensions.swift
//  Virtual Tourist
//
//  Created by Rajanikant Deshmukh on 28/03/18.
//  Copyright © 2018 Rajanikant Deshmukh. All rights reserved.
//

import Foundation
import UIKit
import MapKit

extension UIViewController {
    
    func showAlertDialog(title: String, message: String, dismissHandler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: dismissHandler))
        self.present(alert, animated: true)
    }
}

extension Place {
    
    func getAnnotation() -> MKAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = self.locationString
        annotation.coordinate = CLLocationCoordinate2DMake(self.latitude, self.longitude)
        return annotation
    }
}

extension Photo {
    
    convenience init?(_ dictionary: NSDictionary) {
        self.init()
        self.id = (dictionary["id"] as! String)
        self.title = (dictionary["title"] as! String)
        self.url = (dictionary["url_m"] as! String)
        self.width = (dictionary["width_m"] as! Int16)
        self.height = (dictionary["height_m"] as! Int16)
    }
    
    func setFrom(_ dictionary: NSDictionary) {
        self.id = (dictionary["id"] as! String)
        self.title = (dictionary["title"] as! String)
        self.url = (dictionary["url_m"] as? String) ?? ""
        self.width = Int16(dictionary["width_m"] as? String ?? "0")!
        self.height = Int16(dictionary["height_m"] as? String ?? "0")!
    }
}
