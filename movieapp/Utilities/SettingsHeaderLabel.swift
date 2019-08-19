//
//  SettingsHeaderLabel.swift
//  movieapp
//
//  Created by Serxhio Gugo on 8/18/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit

class SettingsHeaderLabel: UILabel {
    
    init(title:String = "Default text", frame: CGRect = .zero) {
        super.init(frame: frame)
        self.text = title
        self.textColor = .sunnyOrange
        self.backgroundColor = .blueDark3
        self.font = UIFont(name: Fonts.latoHeavy, size: 20)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
