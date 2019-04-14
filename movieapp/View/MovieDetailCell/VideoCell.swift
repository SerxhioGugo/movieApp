//
//  VideoCell.swift
//  movieapp
//
//  Created by Serxhio Gugo on 4/12/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit

class VideoCell: UICollectionViewCell {
    
    let trailerLabel: UILabel = {
        let label = UILabel()
        label.text = "TRAILERS"
        label.font = UIFont(name: Fonts.latoBold, size: 16)
        label.textColor = .sunnyOrange
        label.numberOfLines = 1
        return label
    }()
    
    let trailerController = TrailerController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(trailerLabel)
        trailerLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 0))
        
        addSubview(trailerController.view)
        trailerController.view.anchor(top: trailerLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
