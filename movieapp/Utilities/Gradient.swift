//
//  Gradient.swift
//  movieapp
//
//  Created by Serxhio Gugo on 3/31/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit

class Gradient: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        if let layer = self.layer as? CAGradientLayer {
            layer.colors = [UIColor.blueDark3.cgColor , UIColor.blueDark1.cgColor]
            layer.locations = [0.0, 1.2]
        }
    }
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
