//
//  Errors.swift
//  Virtual Tourist
//
//  Created by Rajanikant Deshmukh on 02/04/18.
//  Copyright © 2018 Rajanikant Deshmukh. All rights reserved.
//

import Foundation

enum Errors: String {
    case NetworkError = "Please check your network and try again."
    case ServerError = "Server messed up. Please contact developer."
    case DatabaseError = "Database Error."
    case UnknownError = "The app is messed up. Please contact developer."
}
