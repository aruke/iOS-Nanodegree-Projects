//
//  PostsViewController.swift
//  JSON Feed Reader
//
//  Created by Rajanikant Deshmukh on 02/04/18.
//  Copyright © 2018 Rajanikant Deshmukh. All rights reserved.
//

import UIKit

class PostsViewController: UIViewController {

    @IBOutlet weak var emptyView: UIStackView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewState(.EMPTY)
        refrshPosts()
    }

    @IBAction func refreshPosts(_ sender: Any) {
        refrshPosts()
    }
    
    func refrshPosts() {
    }
    
    // MARK: View State Handler
    
    enum ViewState {
        case LOADING
        case EMPTY
        case IDLE
    }
    
    func setViewState(_ viewState: ViewState) {
        switch viewState {
        case .LOADING:
            tableView.isHidden = true
            emptyView.isHidden = true
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            break
        case .EMPTY:
            tableView.isHidden = true
            emptyView.isHidden = false
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
            break
        case .IDLE:
            tableView.isHidden = false
            emptyView.isHidden = true
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
            break
        }
    }
}
