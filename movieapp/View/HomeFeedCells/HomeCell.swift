//
//  HomeCell.swift
//  movieapp
//
//  Created by Serxhio Gugo on 3/13/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit

class HomeCell: UICollectionViewCell {
    
    let movieViewController = UIViewController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(movieViewController.view)
        movieViewController.view.backgroundColor = .blue
        movieViewController.view.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
