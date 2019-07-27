//
//  SignInViewModel.swift
//  movieapp
//
//  Created by Serxhio Gugo on 7/25/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import Foundation

class SignInViewModel {
    
    var bindableIsFormValid = Bindable<Bool>()
    
    var email: String? { didSet {checkFormValidity()} }
    var password: String? { didSet{checkFormValidity()} }
    
    fileprivate func checkFormValidity() {
        let isFormValid = email?.isEmpty == false
                       && password?.isEmpty == false
        bindableIsFormValid.value = isFormValid
    }    
}
