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
    
    init?(_ dictionary: NSDictionary) {
        // These keys are compulsory for Parse and every object will have it
        self.objectId = (dictionary["objectId"] as! String)
        self.uniqueKey = (dictionary["uniqueKey"] as! String)
        // TODO Parse Date
        self.createdAt =  dateFormatter.date(from: dictionary["createdAt"] as! String) ?? Date()
        self.updatedAt = Date()
        
        // Since the Parse data is not being validated on ServerSide
        // We implemement sanity checks on our side
        
        // Sanity check for name
        if dictionary["firstName"] == nil || dictionary["lastName"] == nil {
            return nil
        }
        self.firstName = dictionary["firstName"] as! String
        self.lastName = (dictionary["lastName"] as! String)
        
        // Sanity check for locations
        if dictionary["latitude"] == nil || dictionary["longitude"] == nil {
            return nil
        }
        self.latitude = (dictionary["latitude"] as! Double)
        self.longitude = (dictionary["longitude"] as! Double)
        
        // Sanity check for address and media URL
        if dictionary["mapString"] == nil || dictionary["mediaURL"] == nil {
            return nil
        }
        self.mapString = (dictionary["mapString"] as! String)
        self.mediaURL = (dictionary["mediaURL"] as! String)
    }
}
