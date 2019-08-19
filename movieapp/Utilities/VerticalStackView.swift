//
//  VerticalStackView.swift
//  movieapp
//
//  Created by Serxhio Gugo on 4/1/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit

class VerticalStackView: UIStackView {
    init(arrangedSubviews: [UIView], spacing: CGFloat = 0) {
        super.init(frame: .zero)
        self.spacing = spacing
        self.axis = .vertical
//        self.distribution = .fillEqually
        arrangedSubviews.forEach({addArrangedSubview($0)})
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class HorizontalStackView: UIStackView {
    init(arrangedSubviews: [UIView], spacing: CGFloat = 0) {
        super.init(frame: .zero)
        self.spacing = spacing
        self.axis = .horizontal
        arrangedSubviews.forEach({addArrangedSubview($0)})
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
