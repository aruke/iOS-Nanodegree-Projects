//
//  PlaySoundViewController.swift
//  Pitch Perfect
//
//  Created by Rajanikant Deshmukh on 01/12/17.
//  Copyright © 2017 Rajanikant Deshmukh. All rights reserved.
//

import UIKit

class PlaySoundViewController: UIViewController {

    var recordedAudioUrl: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(recordedAudioUrl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
