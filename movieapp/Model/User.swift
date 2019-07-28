//
//  User.swift
//  movieapp
//
//  Created by Serxhio Gugo on 7/27/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit

class User {
    let name: String
    let email: String
    let imageUrl: String
    
    init(dictionary: [String : Any]) {
        let name = dictionary["name"] as? String ?? "Your name"
        let email = dictionary["email"] as? String ?? "Your email"
        let imageUrl = dictionary["imageUrl"] as? String ?? ""
        
        self.name = name
        self.email = email
        self.imageUrl = imageUrl
    }
}
