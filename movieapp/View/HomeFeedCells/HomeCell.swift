//
//  HomeCell.swift
//  movieapp
//
//  Created by Serxhio Gugo on 3/13/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit

class HomeCell: UICollectionViewCell {
    
    let movieController = MovieController()
    
    let categoryTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "Upcoming"
        label.font = .boldSystemFont(ofSize: 25)
        label.backgroundColor = .clear
        label.textColor = .sunnyOrange
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(categoryTypeLabel)
        categoryTypeLabel.anchor(top: topAnchor,
                                 leading: leadingAnchor,
                                 bottom: nil,
                                 trailing: trailingAnchor,
                                 padding: .init(top: 50, left: 10, bottom: 0, right: 0),
                                 size: .init(width: 0, height: 50))
        
        addSubview(movieController.view)
        movieController.view.anchor(top: categoryTypeLabel.bottomAnchor,
                                    leading: leadingAnchor,
                                    bottom: bottomAnchor,
                                    trailing: trailingAnchor)
        
        movieController.view.backgroundColor = .clear
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
