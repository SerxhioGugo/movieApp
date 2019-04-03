//
//  MovieDetailCell.swift
//  movieapp
//
//  Created by Serxhio Gugo on 4/1/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit
import SDWebImage

class MovieDetailCell: UICollectionViewCell {
    
    var dataSource: Any? {
        didSet {
            guard
                let movieDetails = dataSource as? MovieDetail,
                let wallpaperImage = movieDetails.posterPath,
                let wallpaperUrl = URL(string: "https://image.tmdb.org/t/p/w500\(wallpaperImage)")
                else { return}
            self.wallpaperImage.sd_setImage(with: wallpaperUrl)
            self.movieTitleLabel.text = movieDetails.title ?? "No title provided for this movie."
            self.runtimeLabel.text = "\(movieDetails.runtime ?? 0)"
            self.overviewLabel.text = movieDetails.overview ?? "Description not provided."
        }
    }
    
    let blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        return blurEffectView
    }()
    
    let wallpaperImage: UIImageView = {
       let img = UIImageView()
        img.contentMode = .scaleToFill
        img.clipsToBounds = true
        return img
    }()
    
    let posterImage: UIImageView = {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "marvelPoster")
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true
        img.dropShadow()
        return img
    }()
    
    let playTrailerButton: UIButton = {
        let button = UIButton()
        button.setTitle("PLAY TRAILER", for: .normal)
        button.titleLabel?.textColor = .white
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.backgroundColor = .sunnyOrange
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(handlePlayTrailer), for: .touchUpInside)
        return button
    }()
    
    let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.text = "Captain Marvel"
        return label
    }()
    
    let runtimeLabel: UILabel = {
        let label = UILabel()
        label.text = "2h 32min"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 1
        return label
    }()
    
    let overviewLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "The story follows Carol Danvers as she becomes one of the universe’s most powerful heroes when Earth is caught in the middle of a galactic war between two alien races. Set in the 1990s, Captain Marvel is an all-new adventure from a previously unseen period in the history of the Marvel Cinematic Universe."
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .myBlack
        
        addSubview(wallpaperImage)
        wallpaperImage.anchor(top: topAnchor,
                              leading: leadingAnchor,
                              bottom: nil, trailing: trailingAnchor,
                              size: .init(width: 0 , height: frame.height / 1.5))
        
        let stackView = VerticalStackView(arrangedSubviews: [
                    movieTitleLabel,
                    runtimeLabel,
                    overviewLabel
                    ], spacing: 5)
        
        addSubview(stackView)
        stackView.anchor(top: wallpaperImage.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0),size: .init(width: 0, height: 200))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    
    @objc func handlePlayTrailer() {
        print("Handle trailer pressed")
    }
}
