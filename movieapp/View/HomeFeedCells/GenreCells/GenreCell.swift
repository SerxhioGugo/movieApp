//
//  GenreCell.swift
//  movieapp
//
//  Created by Serxhio Gugo on 5/2/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit

class GenreCell: UICollectionViewCell {
    
    let genreLabel: UILabel = {
        let label = UILabel()
        label.text = "Action"
        label.textColor = .white
        label.backgroundColor = .gray
        label.layer.cornerRadius = 12
        label.clipsToBounds = true
        label.textAlignment = .center
        label.font = UIFont(name: Fonts.latoMedium, size: 18)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.white.cgColor
        return label
    }()
    
    let selectedLine: UIView = {
       let view = UIView()
        view.backgroundColor = .sunnyOrange
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.isHidden = true
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
//        backgroundColor = .blueDark3
    }
    
    fileprivate func setupLayout() {
//        addSubview(genreLabel)
//        genreLabel.centerInSuperview(size: .init(width: frame.width, height: 50))
        
//        selectedLine.constrainHeight(constant: 2)
        
        let verticalStackView = VerticalStackView(arrangedSubviews: [
            genreLabel,
            selectedLine
            ])
        addSubview(verticalStackView)
        verticalStackView.fillSuperview()
    }

    
    override var isSelected: Bool {
        didSet {
            genreLabel.textColor = isSelected ? .sunnyOrange : .white
            genreLabel.backgroundColor = isSelected ? .darkGray : .gray
            genreLabel.layer.borderColor = isSelected ? UIColor.sunnyOrange.cgColor : UIColor.white.cgColor
        }
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
