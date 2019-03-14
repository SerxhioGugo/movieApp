//
//  MenuCell.swift
//  movieapp
//
//  Created by Serxhio Gugo on 3/13/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit

class MenuCell: UICollectionViewCell {
    
    let label: UILabel = {
        let l = UILabel()
        l.text = "Menu Item"
        l.textAlignment = .center
        l.textColor = .lightGray
        return l
    }()
    
    //CHange the text color when the cell is selected
    override var isSelected: Bool {
        didSet {
            label.textColor = isSelected ? .black : .lightGray
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        label.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
