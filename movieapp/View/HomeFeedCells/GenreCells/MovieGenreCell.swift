//
//  MovieGenreCell.swift
//  movieapp
//
//  Created by Serxhio Gugo on 6/16/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit
import SDWebImage

class MovieGenreCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(posterImageView)
        posterImageView.fillSuperview()
    }
    

    
    var dataSource: Any? {
        didSet {
            guard
                let movies = dataSource as? MovieResults,
                let image = movies.posterPath,
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
        return image
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
