//
//  PostContentViewController.swift
//  JSON Feed Reader
//
//  Created by Rajanikant Deshmukh on 02/04/18.
//  Copyright © 2018 Rajanikant Deshmukh. All rights reserved.
//

import UIKit

class PostContentViewController: BaseViewController {
    
    static let STORYBOARD_ID = "PostContentViewController"
    
    var post: Post!
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var navItem: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navItem.title = post.title
        webView.scrollView.bounces = false
        
        // Check if THML contents are available
        let htmlContent = post.content_html
        if htmlContent == nil || (htmlContent?.isEmpty)! {
            
            // Switch to text
            let textContent = post.content_text
            if textContent == nil || (textContent?.isEmpty)! {
                // Show Error
            } else {
                let contents = "<html><body>\(textContent!)</body></html>"
                webView.loadHTMLString(contents, baseURL: URL(string: post.url!))
            }
            
            
        } else {
            webView.loadHTMLString(htmlContent!, baseURL: URL(string: post.url!))
        }
    }
    
    @IBAction func onDoneClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    class func instantiate(caller: UIViewController, post: Post) -> PostContentViewController {
        // Instantiate VC from storyboard
        let contentViewController: PostContentViewController = caller.storyboard?.instantiateViewController(withIdentifier: STORYBOARD_ID) as! PostContentViewController
        // Set required parameters and return
        contentViewController.post = post
        return contentViewController
    }
}
