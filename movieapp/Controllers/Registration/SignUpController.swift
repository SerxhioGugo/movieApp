//
//  SignUpController.swift
//  movieapp
//
//  Created by Serxhio Gugo on 7/8/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit
import Firebase
import JGProgressHUD

class SignUpController: UIViewController {
    
    //MARK: Objects
    let signUpViewModel = SignUpViewModel()
    
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
        button.clipsToBounds = true
        button.imageView?.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        return button
    }()
    
    let nameTextField: UITextField = {
        let tf = CustomTextField(padding: 16)
        tf.tintColor = .sunnyOrange
        tf.textColor = .sunnyOrange
        tf.font = UIFont(name: Fonts.latoRegular, size: 20)
        tf.attributedPlaceholder = NSAttributedString(string: "Enter full name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        tf.backgroundColor = .myGrayColor
        tf.keyboardAppearance = UIKeyboardAppearance.dark
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return tf
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
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.backgroundColor = .myGrayColor
        button.layer.cornerRadius = 20
        button.titleLabel?.font = UIFont(name: Fonts.latoBold, size: 24)
        button.isEnabled = false
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    
    let signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Back to Sign In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.latoRegular, size: 20)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.addTarget(self, action: #selector(goToSignIn), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blueDark3
        setupLayout()
        setupNotificationObservers()
        setupTapGesture()
        setupSignUpViewModelObserver()
    }
    
    lazy var stackView = UIStackView(arrangedSubviews: [
        logoIcon,
        selectPhotoButton,
        nameTextField,
        emailTextField,
        passwordTextField,
        signInButton,
        signUpButton
        ])
    
    
    //MARK: Layout
    fileprivate func setupLayout() {
        self.navigationController?.isNavigationBarHidden = true
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 32, bottom: 0, right: 32))
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
        view.addSubview(dismissButton)
        dismissButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: 32), size: .init(width: 34, height: 34))
    }
    
    //MARK: Actions
    
    @objc func handleSelectPhoto() {
        print("Select photo pressed")
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true)
    }
    
    @objc fileprivate func handleTextChange(textField: UITextField) {
        if textField == nameTextField {
            self.signUpViewModel.name = textField.text
        } else if textField == emailTextField {
            self.signUpViewModel.email = textField.text
        } else if textField == passwordTextField  {
            signUpViewModel.password = textField.text
        }
    }
    
    fileprivate func setupSignUpViewModelObserver() {
        
        signUpViewModel.bindableIsFormValid.bind { [unowned self] isFormValid in
            guard let isFormValid = isFormValid else { return }
            
            self.signUpButton.isEnabled = isFormValid
            
            self.signUpButton.backgroundColor = isFormValid ? .sunnyOrange : .myGrayColor
            self.signUpButton.setTitleColor(isFormValid ? .white : .lightGray, for: .normal)
        }

        signUpViewModel.bindableImage.bind { [unowned self] image in
            self.selectPhotoButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        signUpViewModel.bindableIsSigningUp.bind { [unowned self] isSigningup in
            if isSigningup == true {
                self.signUpHUD.textLabel.text = "Register"
                self.signUpHUD.show(in: self.view)
            } else {
                self.signUpHUD.dismiss(animated: true)
            }
        }
    }
    
    @objc func handleDissmiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
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
    
    @objc fileprivate func handleKeyboardShow(notification: Notification) {
        //how tall the keyboard is
        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = value.cgRectValue
        //how tall the gap is from sign in button to the bottom of screen
        let bottomSpace = view.frame.height - stackView.frame.origin.y - stackView.frame.height
        
        let difference = keyboardFrame.height - bottomSpace
        self.view.transform = CGAffineTransform(translationX: 0, y: -difference - 18)
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
    
    fileprivate func showHUDWithError(error: Error) {
        signUpHUD.dismiss(animated: true)
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Failed Registration"
        hud.detailTextLabel.text = error.localizedDescription
        hud.show(in: self.view)
        hud.dismiss(afterDelay: 3)
    }
    
    let signUpHUD = JGProgressHUD(style: .dark)
    
    @objc func goToSignIn() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //Handle register
    @objc fileprivate func handleSignUp() {
        self.handleTapDismiss()
        signUpViewModel.performSignUp { [weak self] err in
            if let err = err {
                self?.showHUDWithError(error: err)
                return
            }
            print("Finished registering user")
            self?.dismiss(animated: true)
        }
    }
}

extension SignUpController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
//        signUpViewModel.image = image
        signUpViewModel.bindableImage.value = image
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
}
