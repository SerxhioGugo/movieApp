//
//  MovieHeader.swift
//  movieapp
//
//  Created by Serxhio Gugo on 3/23/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit

class MovieHeader: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .green
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
