//
//  TableViewController+TableViewDelegate.swift
//  On The Map
//
//  Created by Rajanikant Deshmukh on 20/03/18.
//  Copyright © 2018 Rajanikant Deshmukh. All rights reserved.
//

import Foundation
import UIKit

extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if studentLocations == nil {
            return 0
        }
        return studentLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let studentLocation = studentLocations[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellReuseIdentifier)
        cell?.textLabel?.text = "\(studentLocation.firstName) \(studentLocation.lastName)"
        cell?.detailTextLabel?.text = studentLocation.mapString
        // TODO Load Student Image
        //cell?.imageView?.image
        return cell!
    }
}
