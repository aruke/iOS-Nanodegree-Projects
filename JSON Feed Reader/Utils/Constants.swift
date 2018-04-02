//
//  Constants.swift
//  JSON Feed Reader
//
//  Created by Rajanikant Deshmukh on 02/04/18.
//  Copyright © 2018 Rajanikant Deshmukh. All rights reserved.
//

import Foundation

class JsonFeedOrg {
    static let WEBSITE = "https://jsonfeed.org/"
    static let SPECIFICATIONS = "https://jsonfeed.org/version/1"
    static let FEED = "https://jsonfeed.org/feed.json"
}

enum Errors: Error {
    case NetworkError
    case ServerError
    case LocalDatabaseError
}
