//
//  SignInViewModel.swift
//  movieapp
//
//  Created by Serxhio Gugo on 7/25/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import Foundation
import Firebase

class SignInViewModel {
    
    var bindableIsFormValid = Bindable<Bool>()
    var bindableIsSigningIn = Bindable<Bool>()
    
    var email: String? { didSet {checkFormValidity()} }
    var password: String? { didSet{checkFormValidity()} }
    
    fileprivate func checkFormValidity() {
        let isFormValid = email?.isEmpty == false
                       && password?.isEmpty == false
        bindableIsFormValid.value = isFormValid
    }
    
    func performLogin(completion: @escaping (Error?) -> Void) {
        guard let email = email, let password = password else { return }
        bindableIsSigningIn.value = true
        Auth.auth().signIn(withEmail: email, password: password) { (res, err) in
            completion(err)
        }
        
    }
}
