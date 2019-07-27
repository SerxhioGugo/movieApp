//
//  SignInController.swift
//  movieapp
//
//  Created by Serxhio Gugo on 7/5/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit

class SignInController: UIViewController {
    
    //MARK: Objects
    let signInViewModel = SignInViewModel()
    
    
    //MARK: UIProperties
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
        img.heightAnchor.constraint(equalToConstant: 100).isActive = true
        return img
    }()
    
    let emailTextField: UITextField = {
        let tf = CustomTextField(padding: 16)
        tf.tintColor = .sunnyOrange
        tf.textColor = .sunnyOrange
        tf.font = UIFont(name: Fonts.latoRegular, size: 20)
        tf.attributedPlaceholder = NSAttributedString(string: "Enter e-mail", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        tf.backgroundColor = .myGrayColor
        tf.keyboardType = .emailAddress
        tf.keyboardAppearance = UIKeyboardAppearance.dark
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
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
        tf.keyboardAppearance = UIKeyboardAppearance.dark
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return tf
    }()
    
    
    
    let signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign in", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.backgroundColor = .myGrayColor
        button.layer.cornerRadius = 20
        button.titleLabel?.font = UIFont(name: Fonts.latoBold, size: 24)
        button.isEnabled = false
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Don't have an account yet? Sign Up here.", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.latoRegular, size: 22)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.addTarget(self, action: #selector(goToSignUp), for: .touchUpInside)
        return button
    }()
    
    let termsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Read Terms of Service", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.latoRegular, size: 16)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        return button
    }()
    
    let privacyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Read Privacy Policy", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.latoRegular, size: 16)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blueDark3
        setupLayout()
        setupNotificationObservers()
        setupTapGesture()
        setupSingInViewModelObserver()
    }
    
    lazy var stackView = UIStackView(arrangedSubviews: [
        logoIcon,
        emailTextField,
        passwordTextField,
        signInButton,
        signUpButton
        ])

    //MARK: Layout
    fileprivate func setupLayout() {
        
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.anchor(top: nil,
                         leading: view.leadingAnchor,
                         bottom: nil, trailing: view.trailingAnchor,
                         padding: .init(top: 0, left: 32, bottom: 0, right: 32))
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addSubview(dismissButton)
        dismissButton.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                             leading: nil, bottom: nil,
                             trailing: view.safeAreaLayoutGuide.trailingAnchor,
                             padding: .init(top: 0, left: 0, bottom: 0, right: 32),
                             size: .init(width: 34, height: 34))
        
        let bottomSectionStack = UIStackView(arrangedSubviews: [
            termsButton,
            privacyButton
            ])
        
        bottomSectionStack.distribution = .fillEqually
        bottomSectionStack.axis = .horizontal
        
        view.addSubview(bottomSectionStack)
        bottomSectionStack.anchor(top: nil,
                                  leading: view.leadingAnchor,
                                  bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                  trailing: view.trailingAnchor,
                                  size: .init(width: 0, height: 80))
    }
    
    //MARK: Actions
    
    @objc fileprivate func handleTextChange(textField: UITextField) {
        if textField == emailTextField {
            signInViewModel.email = textField.text
        } else if textField == passwordTextField  {
            signInViewModel.password = textField.text
        }
    }
    
    fileprivate func setupSingInViewModelObserver() {
        
        signInViewModel.bindableIsFormValid.bind { [unowned self] isFormValid in
            guard let isFormValid = isFormValid else { return }
            self.signInButton.isEnabled = isFormValid
            
            self.signInButton.backgroundColor = isFormValid ? .sunnyOrange : .myGrayColor
            self.signInButton.setTitleColor(isFormValid ? .white : .lightGray, for: .normal)
        }
    }
    
    @objc func handleDissmiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc fileprivate func handleKeyboardShow(notification: Notification) {
        //how tall the keyboard is
        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = value.cgRectValue
        //how tall the gap is from sign in button to the bottom of screen
        let bottomSpace = view.frame.height - stackView.frame.origin.y - stackView.frame.height
        
        let difference = keyboardFrame.height - bottomSpace
        self.view.transform = CGAffineTransform(translationX: 0, y: -difference - 18)
    }
    //Handling retain cycle/removing observers
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNotificationObservers()
    }
    
    fileprivate func setupTapGesture() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
    }
    
    @objc fileprivate func handleKeyboardHide() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.transform = .identity
        })
    }
    
    @objc fileprivate func handleTapDismiss() {
        self.view.endEditing(true)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.transform = .identity
        })
    }
    
    @objc func goToSignUp() {
        let signUpController = SignUpController()
        //signUpController.modalPresentationStyle = .currentContext
        signUpController.modalTransitionStyle = .flipHorizontal
        self.present(signUpController,animated: true)
    }
    
}
