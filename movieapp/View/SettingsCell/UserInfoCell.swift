//
//  UserInfoCell.swift
//  movieapp
//
//  Created by Serxhio Gugo on 7/27/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit

class UserInfoCell: UITableViewCell {
    
    let imageProfile: UIImageView = {
       let img = UIImageView()
        img.clipsToBounds = true
//        img.backgroundColor = .red
        img.layer.cornerRadius = 80 / 2
        img.image = #imageLiteral(resourceName: "user")
        img.layer.borderColor = UIColor.sunnyOrange.cgColor
        img.layer.borderWidth = 2
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    let nameProfile: UILabel = {
        let label = UILabel()
        label.text = "Your full name"
        label.font = UIFont(name: Fonts.latoHeavy, size: 24)
        label.textColor = .white
        return label
    }()
    
    let emailProfile: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.latoMedium, size: 18)
        label.textColor = .lightGray
        label.text = "Your e-mail"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .blueDark3
        addSubview(imageProfile)
        imageProfile.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 20, left: 20, bottom: 10, right: 10), size: .init(width: 80, height: 80))
        
        
        let verticalStackView = VerticalStackView(arrangedSubviews: [
            UIView(),
            nameProfile,
            emailProfile,
            UIView()
            ])
        
        addSubview(verticalStackView)
        verticalStackView.distribution = .fillEqually
        //        verticalStackView.fillSuperview(padding: .init(top: 10, left: 10, bottom: 10, right: 10))
        verticalStackView.anchor(top: topAnchor, leading: imageProfile.trailingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 10, left: 10, bottom: 10, right: 10))
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


