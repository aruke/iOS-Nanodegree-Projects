//
//  StudentLocationViewController.swift
//  On The Map
//
//  Created by Rajanikant Deshmukh on 26/03/18.
//  Copyright © 2018 Rajanikant Deshmukh. All rights reserved.
//

import Foundation
import UIKit

class StudentLocationViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ParseHandler.shared.loadStudentLocations(limit: 100, skip: 0, onComplete: {error in
            DispatchQueue.main.async(execute: {
                self.studentLocationLoaded(error: error)
            })
        })
    }
    
    func studentLocationLoaded(error: Errors?) {
        // To be overridden
    }
    
    func openUrl(url: String?) {
        if let url = URL(string: url!) {
            let app = UIApplication.shared
            app.open(url, options: [:], completionHandler: nil)
        } else {
            showAlertDialog(title: "Ooops!", message: "The media URL provided by this student is not a valid URL", dismissHandler: nil)
        }
    }
}
