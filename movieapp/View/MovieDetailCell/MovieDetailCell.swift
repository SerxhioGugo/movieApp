//
//  MovieDetailCell.swift
//  movieapp
//
//  Created by Serxhio Gugo on 4/1/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit
import SDWebImage
import Cosmos

class MovieDetailCell: UICollectionViewCell {

    var dataSource: Any? {
        didSet {
            guard
                let movieDetails = dataSource as? MovieDetail,
                let wallpaperImage = movieDetails.backdropPath,
                let wallpaperUrl = URL(string: "https://image.tmdb.org/t/p/original\(wallpaperImage)"),
                let posterImage = movieDetails.posterPath,
                let posterUrl = URL(string: "https://image.tmdb.org/t/p/w500\(posterImage)"),
                let voteAverage = movieDetails.voteAverage,
                let genres = movieDetails.genres,
                let runtime = movieDetails.runtime,
                let date = movieDetails.releaseDate
                else { return}
            
            
            let dateToShowOnUI:String =  DateManager.methodStringFromDate(dateFromString: DateManager.methodDateFromString(stringDate: date) as NSDate)
            
            let formatter = DateComponentsFormatter()
            formatter.allowedUnits = [.hour, .minute]
            formatter.unitsStyle = .abbreviated
            formatter.zeroFormattingBehavior = .pad
            formatter.allowsFractionalUnits = true
            let formatedRuntime = formatter.string(from: TimeInterval(runtime * 60))
            
            UIView.animate(withDuration: 1.4) {
                self.wallpaperImage.sd_setImage(with: wallpaperUrl)
                self.wallpaperImage.alpha = 1
                self.posterImage.sd_setImage(with: posterUrl)
                self.posterImage.alpha = 1
            }
            
            
            self.movieTitleLabel.text = movieDetails.title ?? "No title provided for this movie."
            self.overviewLabel.text = movieDetails.overview ?? "Description not provided."
            self.runtimeLabel.text = " \(formatedRuntime ?? "") • \(genres[0].name ?? "None") • \(dateToShowOnUI)"
            self.cosmosRating.rating = voteAverage / 2
            self.cosmosRating.text = "TMDB: \(voteAverage)"
        }
    }
    
    let blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        return blurEffectView
    }()
    
    let wallpaperImage: UIImageView = {
       let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.alpha = 0
        return img
    }()
    
    let posterImage: UIImageView = {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "imageNotFound")
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        img.alpha = 0
        img.dropShadow()
        return img
    }()
    
    let playTrailerButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(#imageLiteral(resourceName: "fancyPlayButton"), for: .normal)
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(handlePlayTrailer), for: .touchUpInside)
        return button
    }()
    
    let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .sunnyOrange
        label.text = "No title provided"
        label.font = UIFont(name: Fonts.latoHeavy, size: 30)
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let runtimeLabel: UILabel = {
        let label = UILabel()
        label.text = "0h 0min"
        label.textColor = .white
        label.font = UIFont(name: Fonts.latoRegular, size: 12)
        label.numberOfLines = 1
        return label
    }()
    
    let overview: UILabel = {
        let label = UILabel()
        label.text = "OVERVIEW"
        label.textColor = .sunnyOrange
        label.font = UIFont(name: Fonts.latoBold, size: 12)
        label.numberOfLines = 1
        return label
    }()
    
    lazy var cosmosRating: CosmosView = {
        let cosmos = CosmosView()
        cosmos.settings.totalStars = 5
        cosmos.settings.updateOnTouch = false
        cosmos.settings.filledColor = .sunnyOrange
        cosmos.settings.emptyBorderColor = .gray
        cosmos.settings.fillMode = .precise
        cosmos.settings.starSize = 20
        cosmos.rating = 0
        cosmos.settings.textFont = UIFont(name: Fonts.latoMedium, size: 14)!
        cosmos.settings.textColor = .white
        return cosmos
    }()
    
    let overviewLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Not found"
        label.font = UIFont(name: Fonts.latoLight, size: 18)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.myBlack
        
        addSubview(wallpaperImage)
        wallpaperImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, size: .init(width: 0, height: 300))
        
        wallpaperImage.addSubview(playTrailerButton)
        playTrailerButton.centerInSuperview(size: .init(width: 35, height: 35))
        
        addSubview(posterImage)
        
        NSLayoutConstraint.activate([
            posterImage.centerYAnchor.constraint(equalTo: wallpaperImage.bottomAnchor),
            posterImage.leadingAnchor.constraint(equalTo: wallpaperImage.leadingAnchor, constant: 20),
            posterImage.heightAnchor.constraint(equalToConstant: 175),
            posterImage.widthAnchor.constraint(equalToConstant: 125),
            ])
        
        let topStackView = VerticalStackView(arrangedSubviews: [
                    movieTitleLabel,
                    runtimeLabel,
                    cosmosRating,
                    ], spacing: 5)
        
        let overviewStackView = VerticalStackView(arrangedSubviews: [
            overview,
            overviewLabel
            ], spacing: 5)
        
        addSubview(overviewStackView)
        overviewStackView.anchor(top: posterImage.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 20, left: 20, bottom: 20, right: 5))
        
        addSubview(topStackView)
        topStackView.anchor(top: wallpaperImage.bottomAnchor, leading: posterImage.trailingAnchor, bottom: overviewStackView.topAnchor, trailing: trailingAnchor, padding: .init(top: 5, left: 20, bottom: 0, right: 5))
        
    }
    
    @objc func handlePlayTrailer() {
        print("playyyyyy")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    

}
