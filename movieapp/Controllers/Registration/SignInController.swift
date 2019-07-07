//
//  SignInController.swift
//  movieapp
//
//  Created by Serxhio Gugo on 7/5/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit

class SignInController: UIViewController {
    
    
    let dismissButton: UIButton = {
        let button = UIButton()
        button.setTitle("X", for: .normal)
        button.backgroundColor = UIColor.lightGray.withAlphaComponent(0.50)
        button.titleLabel?.textColor = .black
        button.layer.cornerRadius = 17
        button.addTarget(self, action: #selector(handleDissmiss), for: .touchUpInside)
        return button
    }()

    
    let logoIcon: UIImageView = {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "movieIcon.png")
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let selectPhotoButton: UIButton = {
       let button = UIButton(type: .system)
        button.setTitle("Select Photo", for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.latoHeavy, size: 32)
        button.backgroundColor = UIColor.blueDark3
        button.setTitleColor(.sunnyOrange, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 275).isActive = true
        button.layer.cornerRadius = 16
        button.layer.shadowColor = UIColor.sunnyOrange.cgColor
        button.layer.borderColor = UIColor.sunnyOrange.cgColor
        button.layer.borderWidth = 2
        return button
    }()
    
    let emailTextField: UITextField = {
       let tf = CustomTextField(padding: 16)
        tf.tintColor = .sunnyOrange
        tf.textColor = .sunnyOrange
        tf.font = UIFont(name: Fonts.latoRegular, size: 20)
        tf.attributedPlaceholder = NSAttributedString(string: "Enter email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        tf.backgroundColor = .myGrayColor
        tf.keyboardType = .emailAddress
        
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = CustomTextField(padding: 16)
        tf.tintColor = .sunnyOrange
        tf.textColor = .sunnyOrange
        tf.font = UIFont(name: Fonts.latoRegular, size: 20)
        tf.attributedPlaceholder = NSAttributedString(string: "Enter password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        tf.backgroundColor = .myGrayColor
        tf.isSecureTextEntry = true
        return tf
    }()
    
    let signInButton: UIButton = {
       let button = UIButton(type: .system)
        button.setTitle("Sign in", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .sunnyOrange
        button.layer.cornerRadius = 20
        button.titleLabel?.font = UIFont(name: Fonts.latoBold, size: 24)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Don't have an account yet? Sign Up here.", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.latoRegular, size: 20)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blueDark3
//        setupGradientLayer()

        
        let stackView = UIStackView(arrangedSubviews: [
            selectPhotoButton,
            emailTextField,
            passwordTextField,
            signInButton,
            signUpButton
            ])
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 32, bottom: 0, right: 32))
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
        view.addSubview(dismissButton)
        dismissButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: 32), size: .init(width: 34, height: 34))
        
        view.addSubview(logoIcon)
        logoIcon.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: stackView.topAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 32, bottom: 32, right: 32), size: .init(width: 0, height: 100))
        
        //MARK: ADD TERMS AND POLICY BUTTONS HERE HERE
//        let bottomStackView = UIStackView(arrangedSubviews: [
//            UIView(),
//            UIView()
//            ])
    }
    
    @objc func handleDissmiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        let topColor = UIColor.red
        let bottomColor = UIColor.sunnyOrange
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.locations = [0, 1]
        view.layer.addSublayer(gradientLayer)
        gradientLayer.frame = view.bounds
    }
}
