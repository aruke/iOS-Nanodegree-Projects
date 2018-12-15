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
        return Cache.shared.studentLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let studentLocation = Cache.shared.studentLocations[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellReuseIdentifier)
        cell?.textLabel?.text = "\(studentLocation.firstName) \(studentLocation.lastName)"
        cell?.detailTextLabel?.text = studentLocation.mapString
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let studentLocation = Cache.shared.studentLocations[indexPath.row]
        openUrl(url: studentLocation.mediaURL)
        // Deselect the selected row
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
