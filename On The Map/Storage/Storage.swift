//
//  Storage.swift
//  On The Map
//
//  Created by Rajanikant Deshmukh on 23/03/18.
//  Copyright © 2018 Rajanikant Deshmukh. All rights reserved.
//

import Foundation

class UserAuthStorage {
    
    static let shared: UserAuthStorage = UserAuthStorage()
    
    private init() {}
    
    func getStoredUserAuth() -> UdacityAuthResponse? {
        // Return from UserDefaults
        let sessionId = UserDefaults.standard.string(forKey: "UdacityAuthResponse.sessionId")
        let accountKey = UserDefaults.standard.string(forKey: "UdacityAuthResponse.accountKey")
        let expirationString = UserDefaults.standard.string(forKey: "UdacityAuthResponse.dateString")
        if (sessionId != nil && accountKey != nil && expirationString != nil) {
            return UdacityAuthResponse(sessionId: sessionId!, expirationString: expirationString!, accountKey: accountKey!)
        }
        return nil
    }
    
    func storeUserAuth(_ auth: UdacityAuthResponse) {
        // Store in UserDefaults
        UserDefaults.standard.set(auth.sessionId, forKey: "UdacityAuthResponse.sessionId")
        UserDefaults.standard.set(auth.accountKey, forKey: "UdacityAuthResponse.accountKey")
        UserDefaults.standard.set(auth.dateString(), forKey: "UdacityAuthResponse.dateString")
    }
    
    func clearUserAuth() {
        // Clear UserDefaults
        UserDefaults.standard.removeObject(forKey: "UdacityAuthResponse.sessionId")
        UserDefaults.standard.removeObject(forKey: "UdacityAuthResponse.accountKey")
        UserDefaults.standard.removeObject(forKey: "UdacityAuthResponse.dateString")
    }
}
