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
    private let USER_ENDPOINT_URL: URL = URL(string:"https://www.udacity.com/api/users")!
    
    static let shared = AuthHandler()
    
    private override init() {}
    
    func tryAutoLogin(_ onComplete: @escaping (Errors?) -> Void) {
        // First get UserAuthRepsonse from UserDefaults
        // If no existing session, or if expired, return with credential expired error
        let authReponse = UserAuthStorage.shared.getStoredUserAuth() // Get from User Defaults
        if authReponse == nil || (authReponse?.isExpired())! {
            onComplete(Errors.CredentialExpiredError)
            return
        }
        
        // We have session key now, get UserInfo
        getUserData(authResponse: authReponse!, onComplete: onComplete)
    }
    
    func makeLoginCall(email: String, password: String,
                       onComplete: @escaping (Errors?) -> Void) {
        var request = URLRequest(url: AUTH_ENDPOINT_URL)
        
        request.httpMethod = ApiConstants.Method.POST
        request.addValue(ApiConstants.HeaderValue.MIME_TYPE_JSON, forHTTPHeaderField: ApiConstants.HeaderKey.CONTENT_TYPE)
        request.addValue(ApiConstants.HeaderValue.MIME_TYPE_JSON, forHTTPHeaderField: ApiConstants.HeaderKey.ACCEPT)
        
        let credentials = [ApiConstants.UdacityAuth.KEY_UDACITY : [ ApiConstants.UdacityAuth.KEY_USERNAME : email, ApiConstants.UdacityAuth.KEY_PASSWORD: password]]
        let authData = credentials.json()
        print(authData)
        request.httpBody = authData.data(using: .utf8)
        print(request.httpBody ?? "Default Value")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle network error here
            if error != nil {
                if let urlError = error as? URLError {
                    switch urlError.code {
                    case .notConnectedToInternet:
                        onComplete(Errors.NetworkError)
                        break
                    default:
                        onComplete(Errors.ServerError)
                    }
                }
                return
            }
            
            let range = Range(5..<data!.count)
            // Subset of response data
            let newData = data?.subdata(in: range)
            print(String(data: newData!, encoding: .utf8)!)
            
            let responseDict = try! JSONSerialization.jsonObject(with: newData!, options: .allowFragments) as! NSDictionary
            
            if responseDict[ApiConstants.UdacityAuth.KEY_ACCOUNT] != nil && responseDict[ApiConstants.UdacityAuth.KEY_SESSION] != nil {
                // Store user auth in storage and the call get user data
                let authResponse = UdacityAuthResponse(responseDict)
                UserAuthStorage.shared.storeUserAuth(authResponse)
                self.getUserData(authResponse: authResponse, onComplete: onComplete)
                return
            } else if responseDict[ApiConstants.UdacityAuth.KEY_STATUS] != nil {
                let status = responseDict[ApiConstants.UdacityAuth.KEY_STATUS] as! Int
                // 400 : Parameter Missing
                // 403 : Account not found or invalid credentials.
                if status == 403 {
                    onComplete(Errors.WrongCredentialError)
                    return
                }
            } else {
                // If all possible+valid cases are over
                onComplete(Errors.UnknownError)
            }
        }
        task.resume()
    }
    
    private func getUserData(authResponse: UdacityAuthResponse, onComplete: @escaping (Errors?) -> Void) {
        
        var currentUserEndpointUrl: URL = USER_ENDPOINT_URL
        currentUserEndpointUrl.appendPathComponent(authResponse.accountKey)
        
        let request = URLRequest(url: currentUserEndpointUrl)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                if let urlError = error as? URLError {
                    switch urlError.code {
                    case .notConnectedToInternet:
                        onComplete(Errors.NetworkError)
                        break
                    default:
                        onComplete(Errors.ServerError)
                    }
                }
                onComplete(Errors.ServerError)
                return
            }
            let range = Range(5..<data!.count)
            let newData = data?.subdata(in: range)
            print(String(data: newData!, encoding: .utf8)!)
            
            let responseDict = try! JSONSerialization.jsonObject(with: newData!, options: .allowFragments) as! NSDictionary
            
            let userInfo = UserInfo(responseDict)
            Cache.shared.userInfo = userInfo
            
            onComplete(nil)
        }
        
        task.resume()
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
