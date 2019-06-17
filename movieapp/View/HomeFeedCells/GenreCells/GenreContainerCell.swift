//
//  GenreContainerCell.swift
//  movieapp
//
//  Created by Serxhio Gugo on 5/14/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit

class GenreContainerCell: UICollectionViewCell {
    
    let genreController = GenreListController()
    
    let genreLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: Fonts.latoHeavy, size: 24)
        label.textColor = .sunnyOrange
        label.text = "  GENRES"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(genreLabel)
        genreLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, size: .init(width: 0, height: 25))
        
        addSubview(genreController.view)
        genreController.view.anchor(top: genreLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
