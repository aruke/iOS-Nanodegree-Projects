//
//  ParseHandler.swift
//  On The Map
//
//  Created by Rajanikant Deshmukh on 20/03/18.
//  Copyright © 2018 Rajanikant Deshmukh. All rights reserved.
//

import Foundation

class ParseHandler {
    
    private let PARSE_ENDPOINT_URL = URL(string: "https://parse.udacity.com/parse/classes/StudentLocation")!
    
    private let PARSE_APP_ID_HEADER = "X-Parse-Application-Id"
    private let PARSE_API_KEY_HEADER = "X-Parse-REST-API-Key"
    
    private let PARSE_APP_ID = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
    private let PARSE_API_KEY = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
    
    static let shared = ParseHandler()
    
    private init() {}
    
    func loadStudentLocations(limit: Int, skip: Int, onComplete: @escaping (Error?, [StudentLocation]?) -> Void) {
        var request = URLRequest(url: PARSE_ENDPOINT_URL)
        request.addValue(PARSE_APP_ID, forHTTPHeaderField: PARSE_APP_ID_HEADER)
        request.addValue(PARSE_API_KEY, forHTTPHeaderField: PARSE_API_KEY_HEADER)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                // Handle error
                onComplete(error, nil)
                return
            }
            print(String(data: data!, encoding: .utf8)!)
            let responseDict = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSDictionary
            let resultDict: [NSDictionary] = responseDict["results"] as! [NSDictionary]
            
            var studentLocations = [StudentLocation]()
            for dictionary in resultDict {
                studentLocations.append(StudentLocation(dictionary))
            }
            
            onComplete(nil, studentLocations)
        }
        
        task.resume()
    }
    
    func postStudentLocation(locationString: String, mediaUrl: String, lat: Double, lng: Double) {
        var request = URLRequest(url: PARSE_ENDPOINT_URL)
        request.httpMethod = ApiConstants.Method.POST
        request.addValue(PARSE_APP_ID, forHTTPHeaderField: PARSE_APP_ID_HEADER)
        request.addValue(PARSE_API_KEY, forHTTPHeaderField: PARSE_API_KEY_HEADER)
        request.addValue(ApiConstants.HeaderValue.MIME_TYPE_JSON, forHTTPHeaderField: ApiConstants.HeaderKey.CONTENT_TYPE)
        let dataDictionary = [
            "uniqueKey": UserAuthStorage.shared.getStoredUserAuth()?.accountKey,
            "firstName": Cache.shared.userInfo?.firstName,
            "lastName": Cache.shared.userInfo?.lastName,
            "mapString": locationString,
            "mediaURL": mediaUrl,
            "latitude": lat,
            "longitude": lng
            ] as [String : Any]
        let dataString = dataDictionary.json()
        request.httpBody = dataString.data(using: .utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                // Handle error
                return
            }
            print(String(data: data!, encoding: .utf8)!)
        }
        task.resume()
    }
}
