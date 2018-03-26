//
//  StudentLocation.swift
//  On The Map
//
//  Created by Rajanikant Deshmukh on 26/03/18.
//  Copyright © 2018 Rajanikant Deshmukh. All rights reserved.
//

import Foundation

class StudentLocation {
    
    var objectId : String
    var uniqueKey : String
    
    var firstName : String
    var lastName : String
    var latitude : Double
    var longitude : Double
    var mapString : String
    var mediaURL : String
    
    var createdAt : Date
    var updatedAt : Date
    
    let dateFormatter = ISO8601DateFormatter()
    
    init(_ dictionary: NSDictionary) {
        self.objectId = (dictionary["objectId"] as? String)!
        self.uniqueKey = (dictionary["uniqueKey"] as? String)!
        self.firstName = (dictionary["firstName"] as? String)!
        self.lastName = (dictionary["lastName"] as? String)!
        self.latitude = (dictionary["latitude"] as? Double)!
        self.longitude = (dictionary["longitude"] as? Double)!
        self.mapString = (dictionary["mapString"] as? String)!
        self.mediaURL = (dictionary["mediaURL"] as? String) ?? ""
        
        // TODO Parse Date
        self.createdAt =  dateFormatter.date(from: dictionary["createdAt"] as! String) ?? Date()
        self.updatedAt = Date()
    }
}
