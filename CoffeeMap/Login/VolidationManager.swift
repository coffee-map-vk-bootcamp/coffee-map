//
//  VolidationManager.swift
//  CoffeeMap
//
//  Created by Дмитрий Голубев on 23.08.2022.
//

import Foundation

final class VolidationManager {
    
    static func volidationSignUp (email: String, pas1: String, pas2: String) -> VolidationResultSignUp
    {
        if !isValidEmail(email: email) {
            return .badEmail
        }
        if email.isEmpty || pas1.isEmpty || pas2.isEmpty {
            return .notAllFields
        }
        if pas1 != pas2 {
            return .notEqualPass
        }
        
        if pas1.count < 5 {
            return .weakPassword
        }
        return .success
    }
    
    private static func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    static func volidationSignIn (email: String) -> VolidationResultSignIn {
        return .success
    }
}

enum VolidationResultSignUp {
    case success
    case weakPassword
    case notEqualPass
    case notAllFields
    case badEmail
}

enum VolidationResultSignIn {
    case success

}
