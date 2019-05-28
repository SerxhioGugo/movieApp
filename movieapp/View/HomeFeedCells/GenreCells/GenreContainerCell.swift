//
//  GenreContainerCell.swift
//  movieapp
//
//  Created by Serxhio Gugo on 5/14/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit

class GenreContainerCell: UICollectionViewCell {
    
    let genreController = GenreListController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(genreController.view)
        genreController.view.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
