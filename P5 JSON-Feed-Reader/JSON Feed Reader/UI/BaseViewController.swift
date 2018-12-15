//
//  BaseViewController.swift
//  JSON Feed Reader
//
//  Created by Rajanikant Deshmukh on 03/04/18.
//  Copyright © 2018 Rajanikant Deshmukh. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    var dataRespository: DataRepository!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Innitialize data repository, to be accessed by other UIViewControllers
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        dataRespository = appDelegate.dataRepository
    }
}
