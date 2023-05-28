//
//  RegistrationDetails.swift
//  TimeWise
//
//  Created by Dhriti on 21/05/2566 BE.
//

import Foundation
import UIKit

struct RegistrationDetails {
    var email: String
    var password: String
    var username: String
}

extension RegistrationDetails {
    
    static var new: RegistrationDetails {
        
     RegistrationDetails(
        email: "",
        password: "",
        username: ""
     )
    }
}
