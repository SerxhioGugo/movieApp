//
//  CreditsCell.swift
//  movieapp
//
//  Created by Serxhio Gugo on 4/10/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit

class CreditsCell: UICollectionViewCell {
    
    let creditsController = CreditsController()
    
    let castLabel: UILabel = {
       let label = UILabel()
        label.text = "CAST"
        label.font = UIFont(name: Fonts.latoBold, size: 16)
        label.textColor = .sunnyOrange
        label.numberOfLines = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(castLabel)
        castLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 0))
        addSubview(creditsController.view)
        creditsController.view.anchor(top: castLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
