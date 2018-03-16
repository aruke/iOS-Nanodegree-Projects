//
//  GridViewController.swift
//  MemeMe
//
//  Created by Rajanikant Deshmukh on 17/02/18.
//  Copyright © 2018 Rajanikant Deshmukh. All rights reserved.
//

import UIKit

class GridViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var emptyTextView: UILabel!
    @IBOutlet weak var gridView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gridView.delegate = self
        gridView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        gridView.reloadData()
        emptyTextView.isHidden = (MemeStorage.getCount() != 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MemeStorage.getCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCellView", for: indexPath) as! MemeCollectionViewCell
        cell.imageView.image = MemeStorage.get(indexPath.item).memedImage
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Process selection
    }
}

