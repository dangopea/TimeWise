//
//  LoginCredentials.swift
//  TimeWise
//
//  Created by Dhriti on 21/05/2566 BE.
//

import Foundation

struct LoginCredentials {
    var email: String
    var password: String
}

extension LoginCredentials {
    
    static var new: LoginCredentials {
        LoginCredentials(email: "", password: "")
    }
}
