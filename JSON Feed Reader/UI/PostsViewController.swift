//
//  PostsViewController.swift
//  JSON Feed Reader
//
//  Created by Rajanikant Deshmukh on 02/04/18.
//  Copyright © 2018 Rajanikant Deshmukh. All rights reserved.
//

import UIKit

class PostsViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var emptyView: UIStackView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var posts: [Post]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setViewState(.EMPTY)
        refrshPosts()
    }

    @IBAction func refreshPosts(_ sender: Any) {
        refrshPosts()
    }
    
    func refrshPosts() {
        
        // Only loading single feed, thus instantiating directly in ViewController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let feed = PrimaryFeed.shared.get(dataController: appDelegate.dataController)
        
        
        dataRespository.loadPosts(feed: feed!, onError: { error in
            self.setViewState(.EMPTY)
            self.showError(error)
        }, onPostsLoaded: { posts in
            self.setViewState(.IDLE)
            self.posts = posts
            self.reloadTableViewData()
        })
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
    
    func reloadTableViewData() {
        self.tableView.reloadData()
        if (posts?.count ?? 0) == 0 {
            setViewState(.EMPTY)
        } else {
            setViewState(.IDLE)
        }
        
    }
    
    // MARK: UITableViewDelegate Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    // MARK: UITableViewDataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
