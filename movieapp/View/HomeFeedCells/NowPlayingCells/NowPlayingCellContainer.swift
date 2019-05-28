//
//  NowPlayingCellContainer.swift
//  movieapp
//
//  Created by Serxhio Gugo on 5/14/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit

class NowPlayingCellContainer: UICollectionViewCell {
    
    let nowPlayingController = NowPlayingController()
    
    let nowPlayingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.latoMedium, size: 18)
        label.textColor = .sunnyOrange
//        label.textAlignment = .center
        label.text = "● Now Playing"
        return label
    }()
    
    let topPicksLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.latoMedium, size: 18)
        label.textColor = .sunnyOrange
        label.text = "● Top Picks For You"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .myBlack
        
        addSubview(nowPlayingLabel)
        nowPlayingLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, size: .init(width: 0, height: 25))
        
        addSubview(topPicksLabel)
        topPicksLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, size: .init(width: 0, height: 25))
        
        addSubview(nowPlayingController.view)
        nowPlayingController.view.anchor(top: nowPlayingLabel.bottomAnchor, leading: leadingAnchor, bottom: topPicksLabel.topAnchor, trailing: trailingAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
