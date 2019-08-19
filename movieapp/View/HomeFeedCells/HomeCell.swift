//
//  HomeCell.swift
//  movieapp
//
//  Created by Serxhio Gugo on 3/13/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit
import SDWebImage
import SkeletonView

class HomeCell: UICollectionViewCell {
    
    var imageDataSource: Any? {
        didSet {
            guard
                let result = imageDataSource as? MovieResults,
                let image = result.posterPath,
                let imageUrl = URL(string: "https://image.tmdb.org/t/p/w300\(image)")
                else { return }
            posterImageView.sd_setImage(with: imageUrl)
        }
    }
    
    let posterImageView : UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
//        image.layer.cornerRadius = 6
        image.isSkeletonable = true
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(posterImageView)
        posterImageView.anchor(top: topAnchor,
                               leading: leadingAnchor,
                               bottom: bottomAnchor,
                               trailing: trailingAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
