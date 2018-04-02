//
//  PhotoAlbumViewController+Extras.swift
//  Virtual Tourist
//
//  Created by Rajanikant Deshmukh on 28/03/18.
//  Copyright © 2018 Rajanikant Deshmukh. All rights reserved.
//

import Foundation
import UIKit

extension PhotoAlbumViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return album.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Load Image
        let photo = album[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoViewCell", for: indexPath) as! PhotoViewCell
        cell.setPhoto(photo)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Delete photo
        let photo = album.remove(at: indexPath.row)
        dataController.viewContext.delete(photo)
        collectionView.reloadData()
    }
    
    // MARK:- UICollectionViewDelegateFlowLayout Methods
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        let spacificWidth = (width - (2*margin + internalSpacing * CGFloat(numberOfItems - 1)))/CGFloat(numberOfItems)
        return CGSize(width: spacificWidth, height: spacificWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return internalSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return internalSpacing
    }
}
