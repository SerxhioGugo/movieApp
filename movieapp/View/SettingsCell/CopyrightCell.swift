//
//  CopyrightCell.swift
//  movieapp
//
//  Created by Serxhio Gugo on 8/18/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit

class CopyrightCell: UITableViewCell {
    
    let copyrightImage: UIImageView = {
      let image = UIImageView()
        image.image = #imageLiteral(resourceName: "copyright")
        image.clipsToBounds = true
        image.contentMode = .scaleToFill
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(copyrightImage)
        copyrightImage.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
