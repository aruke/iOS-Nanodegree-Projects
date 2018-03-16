//
//  ListViewController.swift
//  MemeMe
//
//  Created by Rajanikant Deshmukh on 17/02/18.
//  Copyright © 2018 Rajanikant Deshmukh. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var emptyView: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if MemeStorage.getCount() == 0 {
            tableView.isHidden = true
            emptyView.isHidden = false
        } else {
            tableView.isHidden = false
            emptyView.isHidden = true
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register XIB file to UITableView
        tableView.register(UINib(nibName: "MemeTableViewCell", bundle: nil), forCellReuseIdentifier: "MemeCellView")
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MemeStorage.getCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let memeObject = MemeStorage.get(indexPath.row)
        let titleText = memeObject.topText + " " + memeObject.bottomText
        
        let cell: MemeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MemeCellView") as! MemeTableViewCell
        
        cell.memeTitleLabel.text = titleText
        cell.memeImageView.image = memeObject.memedImage
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128.0
    }
}
