//
//  UIColorExtension.swift
//  movieapp
//
//  Created by Serxhio Gugo on 3/10/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(red: Int , green: Int, blue: Int) {
        self.init(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0 , alpha: 1.0)
    }
    //Paste HEX value after 0x
    //Example:
    static var myGrayColor: UIColor { return UIColor.init(rgb: 0x2f3640)}
    static var blueDark3: UIColor { return UIColor.init(rgb: 0x022c43)}
    static var blueDark2: UIColor { return UIColor.init(rgb: 0x053F5E)}
    static var blueDark1: UIColor { return UIColor.init(rgb: 0x115173)}
    static var sunnyOrange: UIColor { return UIColor.init(rgb: 0xffd700)}
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue : rgb & 0xFF
        )
    }
}