//
//  TableViewController.swift
//  On The Map
//
//  Created by Rajanikant Deshmukh on 18/03/18.
//  Copyright © 2018 Rajanikant Deshmukh. All rights reserved.
//

import Foundation
import UIKit

class TableViewController: UIViewController {
 
    let TableViewCellReuseIdentifier = "StudentLocationCell"
    
    @IBOutlet weak var tableView: UITableView!
    
    var studentLocations: [StudentLocation]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        ParseHandler.shared.loadStudentLocations(limit: 0, skip: 0, onComplete: {error , studentLocations in
            DispatchQueue.main.async(execute: {
                self.studentLocationLoaded(error: error, studentLocations: studentLocations)
            })
        })
    }
    
    func studentLocationLoaded(error: Error?, studentLocations: [StudentLocation]?) {
        if error != nil {
            // TODO Show alert
            return
        }
        
        self.studentLocations = studentLocations
        tableView.reloadData()
    }
}
