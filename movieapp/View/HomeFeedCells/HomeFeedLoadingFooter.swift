//
//  MovieLoadingFooter.swift
//  movieapp
//
//  Created by Serxhio Gugo on 3/25/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit

class HomeFeedLoadingFooter: UICollectionReusableView {
    
    let aiv: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .whiteLarge)
        aiv.color = .sunnyOrange
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.startAnimating()
        return aiv
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(aiv)
        aiv.centerInSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
