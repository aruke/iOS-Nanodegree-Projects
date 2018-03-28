//
//  PhotoAlbumViewController+Extras.swift
//  Virtual Tourist
//
//  Created by Rajanikant Deshmukh on 28/03/18.
//  Copyright © 2018 Rajanikant Deshmukh. All rights reserved.
//

import Foundation
import UIKit

extension PhotoAlbumViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumCell", for: indexPath)
        return cell
    }    
}
