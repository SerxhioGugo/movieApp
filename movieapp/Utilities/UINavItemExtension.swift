//
//  UINavItemExtension.swift
//  movieapp
//
//  Created by Serxhio Gugo on 3/31/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit

extension UINavigationItem {
    
    func setTitle(_ title: String, subtitle: String) {
        let appearance = UINavigationBar.appearance()
        let textColor = appearance.titleTextAttributes?[NSAttributedString.Key.foregroundColor] as? UIColor ?? .sunnyOrange
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textAlignment = .left
        titleLabel.font = .boldSystemFont(ofSize: 30)
        titleLabel.textColor = textColor
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = subtitle
        subtitleLabel.textAlignment = .left
        subtitleLabel.font = .systemFont(ofSize: 18)
        subtitleLabel.textColor = textColor.withAlphaComponent(0.75)
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        stackView.axis = .vertical
        
        
        self.titleView = stackView
    }
}
