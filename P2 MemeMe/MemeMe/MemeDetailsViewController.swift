//
//  MemeDetailsViewController.swift
//  MemeMe
//
//  Created by Rajanikant Deshmukh on 18/03/18.
//  Copyright © 2018 Rajanikant Deshmukh. All rights reserved.
//

import Foundation
import UIKit

class MemeDetailsViewController: UIViewController {
    
    @IBOutlet weak var memedImageView: UIImageView!
    
    var position: Int!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (position != nil) {
            let meme = MemeStorage.get(position)
            memedImageView.image = meme.memedImage
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (position == nil) {
            let alertController = UIAlertController(title: "No Meme Selected", message: "", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: nil))
            
            present(alertController, animated: true, completion: nil)
        }
    }
}
