//
//  HomeFeedCell.swift
//  movieapp
//
//  Created by Serxhio Gugo on 3/11/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit

class HomeFeedCell: UICollectionViewCell {
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .sunnyOrange
        label.font = .boldSystemFont(ofSize: 22)
        return label
    }()
    
    let homeFeedHorizontalController = HomeFeedHorizontalController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)        
        addSubview(categoryLabel)
        categoryLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 5, left: 10, bottom: 0, right: 0))
        
        addSubview(homeFeedHorizontalController.view)
        homeFeedHorizontalController.view.anchor(top: categoryLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        homeFeedHorizontalController.view.backgroundColor = .blue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
