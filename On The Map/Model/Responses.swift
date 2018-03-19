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
    
    init() {
        self.sessionId = ""
        self.expiration = Date()
        self.accountKey = ""
    }
}
