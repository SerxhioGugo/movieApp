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
        label.text = "Captain Marvel"
        label.font = UIFont(name: "Lato-Medium", size: 30)
        return label
    }()
    
    let runtimeLabel: UILabel = {
        let label = UILabel()
        label.text = "2h 32min"
        label.textColor = .white
        label.font = UIFont(name: "Lato-Regular", size: 12)
        label.numberOfLines = 1
        return label
    }()
    
    let overviewLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Lato-Light", size: 18)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .myBlack

        
        let stackView = VerticalStackView(arrangedSubviews: [
                    wallpaperImage,
                    movieTitleLabel,
                    runtimeLabel,
                    overviewLabel
                    ], spacing: 5)
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 0, left: 0, bottom: 20, right: 0) )
        wallpaperImage.constrainHeight(constant: 500)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    
    @objc func handlePlayTrailer() {
        print("Handle trailer pressed")
    }
}
