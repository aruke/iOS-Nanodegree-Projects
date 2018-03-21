//
//  Errors.swift
//  On The Map
//
//  Created by Rajanikant Deshmukh on 21/03/18.
//  Copyright © 2018 Rajanikant Deshmukh. All rights reserved.
//

import Foundation

class AuthError: Error {
    
    var message: String
    
    init(message: String) {
        self.message = message
    }
    
    var localizedDescription: String {
        return message
    }
}

class UnknownError: Error {
    
    var message: String
    
    init(message: String) {
        self.message = message
    }
    
    var localizedDescription: String {
        return message
    }
}
