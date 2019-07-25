//
//  SignUpViewModel.swift
//  movieapp
//
//  Created by Serxhio Gugo on 7/25/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import Foundation

class SignUpViewModel {
    
    var name: String? { didSet {checkFormValidity() }}
    var email: String? { didSet{ checkFormValidity() }}
    var password: String? { didSet{ checkFormValidity() }}
    
    fileprivate func checkFormValidity() {
        let isFormValid = name?.isEmpty == false
                       && email?.isEmpty == false
                       && password?.isEmpty == false
        
        isFormValidObserver?(isFormValid)
    }
    
    //Reactive approach
    var isFormValidObserver: ((Bool) -> Void)?
    
    
}
