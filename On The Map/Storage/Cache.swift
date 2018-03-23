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
    
    private var _userInfo: UserInfo?
    private var _studentLocations: [StudentLocation]?
    
    private init() {}
    
    var userInfo: UserInfo? {
        set { _userInfo = userInfo }
        get { return _userInfo }
    }
    
    var studentLocations: [StudentLocation]? {
        set { _studentLocations = studentLocations }
        get { return _studentLocations }
    }
}
