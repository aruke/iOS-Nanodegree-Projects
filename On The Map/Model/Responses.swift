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
    
    init(sessionId: String, expirationString: String, accountKey: String) {
        self.sessionId = sessionId
        self.accountKey = accountKey
        
        // Create DateFormatter to format String
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'"
        dateFormatter.timeZone = TimeZone.current
        
        // Set default session expiray to one hour after current time
        let defaultExpiration = Calendar.current.date(byAdding: .hour, value: 1, to: Date())
        
        // Parse session expiration date
        self.expiration =  dateFormatter.date(from: expirationString) ?? defaultExpiration!
    }
    
    init(_ dictionary: NSDictionary) {
        let account: NSDictionary = dictionary[ApiConstants.UdacityAuth.KEY_ACCOUNT] as! NSDictionary
        self.accountKey = account[ApiConstants.UdacityAuth.KEY_ACC_KEY] as! String
        
        let session: NSDictionary = dictionary[ApiConstants.UdacityAuth.KEY_SESSION] as! NSDictionary
        self.sessionId = session[ApiConstants.UdacityAuth.KEY_ID] as! String
        
        let expirationString: String = session[ApiConstants.UdacityAuth.KEY_EXPIRATION] as! String
        
        // Create DateFormatter to format String
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'"
        dateFormatter.timeZone = TimeZone.current
        
        // Set default session expiray to one hour after current time
        let defaultExpiration = Calendar.current.date(byAdding: .hour, value: 1, to: Date())
        
        // Parse session expiration date
        self.expiration =  dateFormatter.date(from: expirationString) ?? defaultExpiration!
    }
    
    func dateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'"
        dateFormatter.timeZone = TimeZone.current
        
        return dateFormatter.string(from: self.expiration)
    }
    
    func isExpired() -> Bool {
        return Date() > self.expiration
    }
}

class UserInfo {
    
    var firstName: String
    var lastName: String
    var nickName: String
    var imageUrl: String
    
    init(_ dictionary: NSDictionary) {
        let user: NSDictionary = dictionary["user"] as! NSDictionary
        
        self.firstName = user["first_name"] as! String
        self.lastName = user["last_name"] as! String
        self.nickName = user["nickname"] as! String
        self.imageUrl = user["_image_url"] as! String
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
