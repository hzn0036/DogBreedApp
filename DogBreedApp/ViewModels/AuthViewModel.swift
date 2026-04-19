//
//  AuthViewModel.swift
//  DogBreedApp
//
//  Created by Heather Nichols on 4/16/26.
//

import Foundation
import Combine
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    
    init() {
        // Check if user is already logged in when app opens
        self.isLoggedIn = Auth.auth().currentUser != nil
    }
    
    func login(email: String, password: String, completion: @escaping (String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(error.localizedDescription)
            } else {
                self.isLoggedIn = true
                completion(nil)
            }
        }
    }
    
    func signUp(email: String, password: String, completion: @escaping (String?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(error.localizedDescription)
            } else {
                self.isLoggedIn = true
                completion(nil)
            }
        }
    }
    
    func logout() {
        try? Auth.auth().signOut()
        self.isLoggedIn = false
    }
}
