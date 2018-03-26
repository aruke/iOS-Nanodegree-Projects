//
//  TableViewController.swift
//  On The Map
//
//  Created by Rajanikant Deshmukh on 18/03/18.
//  Copyright © 2018 Rajanikant Deshmukh. All rights reserved.
//

import Foundation
import UIKit

class TableViewController: StudentLocationViewController {
 
    let TableViewCellReuseIdentifier = "StudentLocationCell"
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func studentLocationLoaded(error: Errors?) {
        if error != nil {
            showAlertDialog(title: "Error", message: (error)!.rawValue, dismissHandler: nil)
            return
        }
        tableView.reloadData()
    }
}
