//
//  MainTabBarController.swift
//  movieapp
//
//  Created by Serxhio Gugo on 3/10/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.barTintColor = UIColor.blueDark3
        
        setupTabBar()
    }
    
    fileprivate func setupTabBar() {
        let homeFeedController = createNavController(vc: HomeFeedController(),
                                                     title: "Now Playing",
                                                     selectedImage: #imageLiteral(resourceName: "movieSelected"),
                                                     unselectedImage: #imageLiteral(resourceName: "movie"))
        
        let searchController = createNavController(vc: SearchController(),
                                                   title: "Search a movie",
                                                   selectedImage: #imageLiteral(resourceName: "searchSelected"),
                                                   unselectedImage: #imageLiteral(resourceName: "search"))
        
        let favoriteController = createNavController(vc: FavoriteController(),
                                                     title: "Favorites",
                                                     selectedImage: #imageLiteral(resourceName: "starSelected"),
                                                     unselectedImage: #imageLiteral(resourceName: "star"))
        
        let aboutController = createNavController(vc: AboutController(),
                                                  title: "About us",
                                                  selectedImage: #imageLiteral(resourceName: "aboutSelected"),
                                                  unselectedImage: #imageLiteral(resourceName: "about"))
        
        viewControllers = [homeFeedController, searchController, favoriteController, aboutController]
    }
    
}
