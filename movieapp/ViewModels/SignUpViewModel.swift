//
//  SignUpViewModel.swift
//  movieapp
//
//  Created by Serxhio Gugo on 7/25/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewModel {
    
    var bindableIsSigningUp = Bindable<Bool>()
    var bindableImage = Bindable<UIImage>()
    var bindableIsFormValid = Bindable<Bool>()
    
    var name: String? { didSet {checkFormValidity() }}
    var email: String? { didSet{ checkFormValidity() }}
    var password: String? { didSet{ checkFormValidity() }}
    
    func performSignUp(completion: @escaping (Error?) -> Void) {
        guard let email = email, let password = password else { return }
        bindableIsSigningUp.value = true
        
        Auth.auth().createUser(withEmail: email, password: password) { (res, err) in
            
            if let error = err {
                completion(error)
                return
            }
            
            print("Successfully registered user: ", res?.user.uid ?? "")
            
            self.saveImageToFirebase(completion: completion)
        }
    }
    
    fileprivate func saveImageToFirebase(completion: @escaping (Error?) -> Void) {
        let filename = UUID().uuidString
        let ref = Storage.storage().reference(withPath: "/images/\(filename)")
        let imageData = self.bindableImage.value?.jpegData(compressionQuality: 0.75) ?? Data()
        ref.putData(imageData, metadata: nil, completion: { (_, err) in
            
            if let err = err {
                completion(err)
                return
            }
            print("Finished uploading image to storage")
            ref.downloadURL(completion: { (url, err) in
                if let err = err {
                    completion(err)
                    return
                }
                self.bindableIsSigningUp.value = false
                print("Download url for image : ", url?.absoluteString ?? "")
                let imageUrl = url?.absoluteString ?? ""
                self.saveInfoToFirestore(imageUrl: imageUrl, completion: completion)
                completion(nil)
            })
        })

    }
    
    fileprivate func saveInfoToFirestore(imageUrl: String, completion: @escaping (Error?) -> Void) {
        let uid = Auth.auth().currentUser?.uid ?? ""
        let docData = ["name": name ?? "" , "uid": uid, "imageUrl": imageUrl]
        Firestore.firestore().collection("users").document(uid).setData(docData) { err in
            if let err = err {
                completion(err)
                return
            }
            completion(nil)
        }
    }
    
    fileprivate func checkFormValidity() {
        let isFormValid = name?.isEmpty == false
            && email?.isEmpty == false
            && password?.isEmpty == false
        bindableIsFormValid.value = isFormValid
    }

    
}
