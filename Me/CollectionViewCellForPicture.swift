//
//  CollectionViewCellForPicture.swift
//  Virtual Tourist
//
//  Created by Ayush Saraswat on 12/20/15.
//  Copyright © 2015 Ayush Saraswat. All rights reserved.
//

import UIKit

class CollectionViewCellForPicture: UICollectionViewCell {
    
    var currentStatus : Bool?
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var removeImage: UIImageView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    
    func setPictureForCell(picture : Picture){
        
        var image: UIImage!
        
        if let picturesImage = picture.image {
            loadingView.hidden = true
            self.userInteractionEnabled = true
            activityView.stopAnimating()
            image = picturesImage
        }else{
            loadingView.hidden = false
            self.userInteractionEnabled = false
            activityView.startAnimating()
            image = UIImage(named: "placeholder")
        }
        
        self.image.image = image
    }
}
