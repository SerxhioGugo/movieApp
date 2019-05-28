//
//  NowPlayingCell.swift
//  movieapp
//
//  Created by Serxhio Gugo on 3/25/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit
import SDWebImage

class NowPlayingCell: UICollectionViewCell {
    
    var dataSource: Any? {
        didSet {
            guard
                let result = dataSource as? MovieResults,
                let wallpaper = result.posterPath,
                let wallpaperUrl = URL(string: "https://image.tmdb.org/t/p/original\(wallpaper)"),
                let title = result.title,
                let release = result.releaseDate
                else { return }
            
            let date = release
            let dateToShowOnUI:String =  DateManager.methodStringFromDate(dateFromString: DateManager.methodDateFromString(stringDate: date) as NSDate)
            
            wallpaperImage.sd_setImage(with: wallpaperUrl)
            movieNameLabel.text = "   \(title) (\(dateToShowOnUI))"
            }
    }
    
    let wallpaperImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "imageNotFound")
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        image.layer.borderWidth = 0.3
        image.layer.borderColor = UIColor.darkGray.cgColor
        return image
    }()
    
    let movieNameLabel: UILabel = {
      let label = UILabel()
        label.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        label.textColor = .white
        label.font = UIFont(name: Fonts.latoMedium, size: 16)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(wallpaperImage)
        wallpaperImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        
        wallpaperImage.addSubview(movieNameLabel)
        movieNameLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0 , height: 50))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
