//
//  PhotoCell.swift
//  iMeiZi
//
//  Created by kingcos on 14/08/2017.
//  Copyright © 2017 kingcos. All rights reserved.
//

import UIKit
import Kingfisher

class PhotoCell: UICollectionViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    
    var iMeizi: MeiZi? {
        didSet {
            guard let urlString = iMeizi?.thumbURL,
                let url = URL(string: urlString) else { return }
    
            photoImageView.kf.setImage(with: url)
        }
    }
}
