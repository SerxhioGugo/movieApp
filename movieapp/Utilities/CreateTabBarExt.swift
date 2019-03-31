//
//  TabBarExtension.swift
//  movieapp
//
//  Created by Serxhio Gugo on 3/10/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit

extension UITabBarController {
    func createNavController(vc: UIViewController, title: String, selectedImage: UIImage, unselectedImage: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: vc)
        
        vc.navigationItem.title = title
        vc.view.backgroundColor = .white
        
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        
        return navController
    }
    
}
