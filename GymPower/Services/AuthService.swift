//
//  AuthService.swift
//  GymPower
//
//  Created by Эмиль Шалаумов on 16/11/2018.
//  Copyright © 2018 Emil Shalaumov. All rights reserved.
//

import Foundation
import Firebase

class AuthService {
    static let instance = AuthService()
    
    var username: String?
    var isLoggedIn = false
    
    func emailLogin(email: String, password: String, completion: @escaping(_ Success: Bool,_ message: String) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                if let errorcode = AuthErrorCode(rawValue: (error?._code)!) {
                    if errorcode == .userNotFound {
                        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                            if error != nil {
                                completion(false, "Error creating account")
                            } else {
                                completion(true, "Successfully created account")
                            }
                        })
                    } else {
                        completion(false, "Incorrect email or password")
                    }
                }
            } else {
                completion(true, "Successfully logged in")
            }
        })
    }
}
