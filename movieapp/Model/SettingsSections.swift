//
//  SettingsSections.swift
//  movieapp
//
//  Created by Serxhio Gugo on 8/5/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

enum SettingsSections: Int, CaseIterable, CustomStringConvertible {
    
    case Social
    case AboutUs
    
    var description: String {
        switch self {
        case .Social: return "Social"
        case .AboutUs: return "About Us"
        }
    }
}

enum SocialOptions: Int, CaseIterable, CustomStringConvertible {
    case EditProfile
    case LogOut
    
    var description: String {
        switch self {
        case .EditProfile: return "Edit profile"
        case .LogOut: return "Log Out"
        }
    }
}


enum AboutUs: Int, CaseIterable, CustomStringConvertible {
    case TermsAndConditions
    case PrivacyPolicy
    case AboutThisApp
    
    var description: String {
        switch self {
        case .TermsAndConditions: return "Terms and conditions"
        case .PrivacyPolicy: return "Privacy Policy"
        case .AboutThisApp: return "About this app"
        }
    }
}
