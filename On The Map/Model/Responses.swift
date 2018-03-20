//
//  Response.swift
//  On The Map
//
//  Created by Rajanikant Deshmukh on 19/03/18.
//  Copyright © 2018 Rajanikant Deshmukh. All rights reserved.
//

import Foundation

class UdacityAuthResponse {
    
    var sessionId: String
    var expiration: Date
    var accountKey: String
    
    init(sessionId: String, expiration: Date, accountKey: String) {
        self.sessionId = sessionId
        self.expiration = expiration
        self.accountKey = accountKey
    }
}

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
    
    let dateFormatter = DateFormatter()
    
    init(_ dictionary: NSDictionary) {
        self.objectId = (dictionary["objectId"] as? String)!
        self.uniqueKey = (dictionary["uniqueKey"] as? String)!
        self.firstName = (dictionary["firstName"] as? String)!
        self.lastName = (dictionary["lastName"] as? String)!
        self.latitude = (dictionary["latitude"] as? Double)!
        self.longitude = (dictionary["longitude"] as? Double)!
        self.mapString = (dictionary["mapString"] as? String)!
        
        //self.mediaURL = (dictionary["mediaURL"] as? String)!
        // TODO Parse Media URL
        self.mediaURL = ""
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale!
        // TODO Parse Date
        self.createdAt = Date()
        self.updatedAt = Date()
    }
}
