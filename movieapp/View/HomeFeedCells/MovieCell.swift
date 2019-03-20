//
//  MovieCell.swift
//  movieapp
//
//  Created by Serxhio Gugo on 3/19/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    let posterImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 2
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "imageNotFound")
        return image
    }()
    
//    var dataSource: Any? {
//        didSet {
//            guard
//                let result = dataSource as? MovieGroup,
//                let res = result.results,
//                let poster = res.pos
//                let posterURL = URL(string: "https://image.tmdb.org/t/p/w300\(poster)")
//                else { return }
//            posterImageView.sd_setImage(with: posterURL)
//        }
//    }
    
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
