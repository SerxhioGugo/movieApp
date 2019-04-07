//
//  MovieHeader.swift
//  movieapp
//
//  Created by Serxhio Gugo on 3/23/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit

class HomeFeedHeader: UICollectionReusableView {

    let nowPlayingLabel: UILabel = {
        let label = UILabel()
        label.text = "Top Picks"
        label.backgroundColor = .clear
        label.font = UIFont(name: Fonts.latoHeavy, size: 18)
        label.textColor = .sunnyOrange
        return label
    }()
    
    let nowPlayingController = NowPlayingController()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(nowPlayingLabel)
        nowPlayingLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 5, bottom: 0, right: 0), size: .init(width: 0, height: 30))
        
        addSubview(nowPlayingController.view)
        nowPlayingController.view.anchor(top: topAnchor,
                                         leading: leadingAnchor,
                                         bottom: nowPlayingLabel.topAnchor,
                                         trailing: trailingAnchor)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
