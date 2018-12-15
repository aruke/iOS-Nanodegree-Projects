//
//  BaseNetworkHandler.swift
//  On The Map
//
//  Created by Rajanikant Deshmukh on 26/03/18.
//  Copyright © 2018 Rajanikant Deshmukh. All rights reserved.
//

import Foundation

class BaseNetworkHandler: NSObject {
    
    typealias ErrorBlock = ((Errors?) -> Void)
    
    func handleError(error: Error!, onComplete: @escaping ErrorBlock) {
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
    }
    
}
