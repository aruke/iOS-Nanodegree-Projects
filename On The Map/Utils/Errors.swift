//
//  Errors.swift
//  On The Map
//
//  Created by Rajanikant Deshmukh on 21/03/18.
//  Copyright © 2018 Rajanikant Deshmukh. All rights reserved.
//

import Foundation

enum Errors: String {
    case WrongCredentialError = "Account not found or invalid credentials."
    case CredentialExpiredError = "Login expired. Please login again."
    case NetworkError = "Please check your network and try again."
    case ServerError = "Server messed up. Please contact developer."
    case UnknownError = "The app is messed up. Please contact developer."
}
