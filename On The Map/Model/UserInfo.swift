//
//  UserInfo.swift
//  On The Map
//
//  Created by Rajanikant Deshmukh on 26/03/18.
//  Copyright © 2018 Rajanikant Deshmukh. All rights reserved.
//

import Foundation

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
