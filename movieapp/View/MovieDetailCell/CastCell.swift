//
//  CastCell.swift
//  movieapp
//
//  Created by Serxhio Gugo on 4/10/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit

class CastCell: UICollectionViewCell {
    
    var castSource: Any? {
        didSet {
            guard
                let cast = castSource as? Cast,
                let actorsImage = cast.profilePath,
                let actorImageUrl = URL(string: "https://image.tmdb.org/t/p/w300\(actorsImage)"),
                let actorName = cast.name
            else { return }
            
            self.actorImageView.sd_setImage(with: actorImageUrl)
            self.actorName.text = actorName
            self.characterName.text = cast.character ?? "Unknown"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(actorImageView)
        actorImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor)
        actorImageView.constrainHeight(constant: frame.height / 1.5)
//        characterName.constrainHeight(constant: 32)
        
        let stackView = VerticalStackView(arrangedSubviews: [
            actorName,
            characterName
            ])
        
        addSubview(stackView)
        stackView.anchor(top: actorImageView.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 20, right: 0))
        

    }
    
    let actorImageView: UIImageView = {
        let img = UIImageView(image: #imageLiteral(resourceName: "imageNotFound"))
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = 6
        return img
    }()
    
    let actorName: UILabel = {
        let label = UILabel()
//        label.text = "Bradley Cooper"
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.font = UIFont(name: Fonts.latoRegular, size: 16)
        return label
    }()
    
    let characterName: UILabel = {
        let label = UILabel()
//        label.text = "Bradley Cooper"
        label.textColor = .lightGray
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: Fonts.latoLight, size: 14)
        label.numberOfLines = 2
        return label
    }()
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
