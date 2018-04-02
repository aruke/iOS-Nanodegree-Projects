//
//  PhotoViewCell.swift
//  Virtual Tourist
//
//  Created by Rajanikant Deshmukh on 02/04/18.
//  Copyright © 2018 Rajanikant Deshmukh. All rights reserved.
//

import UIKit
import Kingfisher

class PhotoViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setPhoto(_ photo: Photo, onComplete: @escaping () -> Void) {
        if let data = photo.image {
            imageView.image = UIImage(data: data)
            onComplete()
        } else {
            imageView.kf.setImage(with: URL(string: photo.url!), completionHandler: { (image, error, _, _) in
                if let thisImage = image {
                    photo.image = UIImagePNGRepresentation(thisImage)
                }
                onComplete()
            })
        }
    }

}
