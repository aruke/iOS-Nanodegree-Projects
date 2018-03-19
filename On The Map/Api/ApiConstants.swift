//
//  ApiConstants.swift
//  On The Map
//
//  Created by Rajanikant Deshmukh on 18/03/18.
//  Copyright © 2018 Rajanikant Deshmukh. All rights reserved.
//

import Foundation

struct ApiConstants {
    
    static let PARSE_ENPOINT_URL = "https://parse.udacity.com/parse/classes"
    static let PARSE_APP_ID = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
    static let REST_API_KEY = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
    
    struct Method {
        static let GET: String = "GET"
        static let POST: String = "POST"
        static let DELETE: String = "DELETE"
    }
    
    struct HeaderKey {
        static let CONTENT_TYPE = "Content-Type"
        static let ACCEPT = "Accept"
    }
    
    struct HeaderValue {
        static let MIME_TYPE_JSON = "application/json"
    }
}
