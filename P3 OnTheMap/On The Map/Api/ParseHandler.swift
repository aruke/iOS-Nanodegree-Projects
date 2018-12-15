//
//  ParseHandler.swift
//  On The Map
//
//  Created by Rajanikant Deshmukh on 20/03/18.
//  Copyright © 2018 Rajanikant Deshmukh. All rights reserved.
//

import Foundation

class ParseHandler: BaseNetworkHandler {
    
    private let PARSE_ENDPOINT_URL = URL(string: "https://parse.udacity.com/parse/classes/StudentLocation")!
    
    private let PARSE_APP_ID_HEADER = "X-Parse-Application-Id"
    private let PARSE_API_KEY_HEADER = "X-Parse-REST-API-Key"
    
    private let PARSE_APP_ID = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
    private let PARSE_API_KEY = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
    
    static let shared = ParseHandler()
    
    var isLoadingStudentLocations: Bool
    
    var callbackArray = [ErrorBlock]()
    
    private override init() {
        isLoadingStudentLocations = false
        callbackArray = [ErrorBlock]()
    }
    
    func loadStudentLocations(limit: Int, skip: Int, onComplete: @escaping ErrorBlock) {
        // Add callback to the array
        callbackArray.append(onComplete)
        
        // If there is exisiting network call going on, return immediately
        if (isLoadingStudentLocations) {
            return
        }
        
        isLoadingStudentLocations = true
        
        let params = "limit=\(limit)&skip=\(skip)&order=-updatedAt"
        
        let requestUrl = URL(string: "\(PARSE_ENDPOINT_URL.absoluteString)?\(params)")
        var request = URLRequest(url: requestUrl!)
        
        request.addValue(PARSE_APP_ID, forHTTPHeaderField: PARSE_APP_ID_HEADER)
        request.addValue(PARSE_API_KEY, forHTTPHeaderField: PARSE_API_KEY_HEADER)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                // Handle error
                self.handleCallbacks(error!)
            }
            
            let responseDict = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSDictionary
            let resultDict: [NSDictionary] = responseDict["results"] as! [NSDictionary]
            
            var studentLocations = [StudentLocation]()
            for dictionary in resultDict {
                if let studLocation = StudentLocation(dictionary) {
                    studentLocations.append(studLocation)
                }
            }
            
            Cache.shared.studentLocations = studentLocations
            self.handleCallbacks()
        }
        
        task.resume()
    }
    
    private func handleCallbacks(_ error: Error? = nil) {
        if error != nil {
            for callback in self.callbackArray {
                self.handleError(error: error, onComplete: callback)
            }
        } else {
            for callback in self.callbackArray {
                callback(nil)
            }
        }
        self.callbackArray.removeAll()
        isLoadingStudentLocations = false
    }
    
    func postStudentLocation(locationString: String, mediaUrl: String, lat: Double, lng: Double, onComplete: @escaping ErrorBlock) {
        var request = URLRequest(url: PARSE_ENDPOINT_URL)
        request.httpMethod = ApiConstants.Method.POST
        request.addValue(PARSE_APP_ID, forHTTPHeaderField: PARSE_APP_ID_HEADER)
        request.addValue(PARSE_API_KEY, forHTTPHeaderField: PARSE_API_KEY_HEADER)
        request.addValue(ApiConstants.HeaderValue.MIME_TYPE_JSON, forHTTPHeaderField: ApiConstants.HeaderKey.CONTENT_TYPE)
        let dataDictionary = [
            "uniqueKey": UserAuthStorage.shared.getStoredUserAuth()?.accountKey as Any,
            "firstName": Cache.shared.userInfo?.firstName as Any,
            "lastName": Cache.shared.userInfo?.lastName as Any,
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
                self.handleError(error: error, onComplete: onComplete)
                return
            }
            print(String(data: data!, encoding: .utf8)!)
            onComplete(nil)
        }
        task.resume()
    }
}
