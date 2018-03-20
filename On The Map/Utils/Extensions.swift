//
//  Extensions.swift
//  On The Map
//
//  Created by Rajanikant Deshmukh on 19/03/18.
//  Copyright © 2018 Rajanikant Deshmukh. All rights reserved.
//

import Foundation
import MapKit

extension Dictionary {
    func json() -> String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(bytes: jsonData, encoding: String.Encoding.utf8) ?? ""
        } catch {
            return ""
        }
    }
}

extension StudentLocation {
    
    func annotation() -> MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.coordinate.latitude = self.latitude
        annotation.coordinate.longitude = longitude
        annotation.title = "\(self.firstName) \(self.lastName)"
        annotation.subtitle = self.mediaURL
        return annotation
    }
}
