//
//  Cache.swift
//  On The Map
//
//  Created by Rajanikant Deshmukh on 23/03/18.
//  Copyright © 2018 Rajanikant Deshmukh. All rights reserved.
//

import Foundation

class Cache {
    
    static let shared = Cache()
    
    var userInfo: UserInfo?
    var studentLocations: [StudentLocation]
    
    private init() {
        studentLocations = [StudentLocation]()
    }
    
    func clear() {
        userInfo = nil
        studentLocations.removeAll()
    }
}
