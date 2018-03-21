//
//  AuthHandler.swift
//  On The Map
//
//  Created by Rajanikant Deshmukh on 18/03/18.
//  Copyright © 2018 Rajanikant Deshmukh. All rights reserved.
//

import Foundation

class AuthHandler: NSObject {
    
    private let AUTH_ENDPOINT_URL: URL = URL(string:"https://www.udacity.com/api/session")!
    private let KEY_UDACITY = "udacity"
    private let KEY_USERNAME = "username"
    private let KEY_PASSWORD = "password"
    private let KEY_ACCOUNT = "account"
    private let KEY_ACC_KEY = "key"
    private let KEY_SESSION = "session"
    private let KEY_ID = "id"
    private let KEY_EXPIRATION = "expiration"
    
    static let shared = AuthHandler()
    
    private override init() {}
    
    func makeLoginCall(email: String, password: String,
                       onComplete: @escaping (Error?, UdacityAuthResponse?) -> Void) {
        var request = URLRequest(url: AUTH_ENDPOINT_URL)
        
        request.httpMethod = ApiConstants.Method.POST
        request.addValue(ApiConstants.HeaderValue.MIME_TYPE_JSON, forHTTPHeaderField: ApiConstants.HeaderKey.CONTENT_TYPE)
        request.addValue(ApiConstants.HeaderValue.MIME_TYPE_JSON, forHTTPHeaderField: ApiConstants.HeaderKey.ACCEPT)
        
        let credentials = [KEY_UDACITY : [ KEY_USERNAME : email, KEY_PASSWORD: password]]
        let authData = credentials.json()
        print(authData)
        request.httpBody = authData.data(using: .utf8)
        print(request.httpBody ?? "Default Value")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                // TODO: Handle error
                onComplete(error!, nil)
                return
            }
            
            // TODO: Check for status code
            
            let range = Range(5..<data!.count)
            let newData = data?.subdata(in: range) /* subset response data! */
            print(String(data: newData!, encoding: .utf8)!)
            onComplete(nil, self.parseUdacityAuthResponse(data: newData))
        }
        task.resume()
    }
    
    private func parseUdacityAuthResponse(data: Data?) -> UdacityAuthResponse? {
        let responseDict = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSDictionary
        
        let account: NSDictionary = responseDict[KEY_ACCOUNT] as! NSDictionary
        let accountKey: String = account[KEY_ACC_KEY] as! String
        
        let session: NSDictionary = responseDict[KEY_SESSION] as! NSDictionary
        let sessionId = session[KEY_ID]
        // TODO: Parse Date
        let expirationString: String = session[KEY_EXPIRATION] as! String
        
        return UdacityAuthResponse(sessionId: sessionId as! String, expiration: Date(), accountKey: accountKey)
    }
    
    // Delete Udacity session
    func makeLogoutCall() {
        var request = URLRequest(url: AUTH_ENDPOINT_URL)
        request.httpMethod = ApiConstants.Method.DELETE
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                // Handle error
                return
            }
            let range = Range(5..<data!.count)
            let newData = data?.subdata(in: range) /* subset response data! */
            print(String(data: newData!, encoding: .utf8)!)
        }
        task.resume()
    }
}
