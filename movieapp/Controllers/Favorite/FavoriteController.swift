//
//  FavoriteController.swift
//  movieapp
//
//  Created by Serxhio Gugo on 3/10/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit

class FavoriteController: BaseListController {
    
    let informationLabel: UILabel = {
        let label = UILabel()
        label.text = "To view your list of Favorites please sign in"
        label.font = UIFont(name: Fonts.latoMedium, size: 20)
        label.textColor = .sunnyOrange
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign in", for: .normal)
        button.setTitleColor(.sunnyOrange, for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.latoHeavy, size: 26)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.sunnyOrange.cgColor
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(handleShowSignInPage), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupNavController()
        
    }

    fileprivate func setupNavController() {
        collectionView.backgroundColor = UIColor.blueDark3
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = UIColor.blueDark3
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.isTranslucent = true
        navigationItem.title = "Sign in"

        let attributes = [NSAttributedString.Key.foregroundColor : UIColor.sunnyOrange]
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
        navigationController?.navigationBar.titleTextAttributes = attributes
    }
    
    @objc func handleShowSignInPage() {
        let signInController = SignInController()
        self.navigationController?.pushViewController(signInController, animated: true)
    }
    
    
    fileprivate func setupUI() {
        view.addSubview(informationLabel)
        informationLabel.centerInSuperview(size: .init(width: view.frame.width - 100, height: 100))
        view.addSubview(signInButton)
        signInButton.anchor(top: informationLabel.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 2, left: 0, bottom: 0, right: 0), size: .init(width: 150, height: 50))
        signInButton.centerXAnchor.constraint(equalTo: informationLabel.centerXAnchor).isActive = true
    }
}
