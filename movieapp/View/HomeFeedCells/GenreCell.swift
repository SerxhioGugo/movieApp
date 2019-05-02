//
//  GenreCell.swift
//  movieapp
//
//  Created by Serxhio Gugo on 5/2/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit

class GenreCell: UICollectionViewCell {
    
    let genreLabel: UILabel = {
        let label = UILabel()
        label.text = "Action"
        label.textColor = .lightGray
        label.textAlignment = .center
        label.font = UIFont(name: Fonts.latoMedium, size: 22)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    fileprivate func setupLayout() {
        addSubview(genreLabel)
        genreLabel.centerInSuperview(size: .init(width: frame.width, height: 50))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
