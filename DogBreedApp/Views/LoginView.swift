//
//  LoginView.swift
//  DogBreedApp
//
//  Created by Heather Nichols on 4/13/26.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("🐶")
                .font(.system(size: 120))
            
            Text("DogBreed App")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
            }
            
            Button("Login") {
                authVM.login(email: email, password: password) { error in
                    if let error = error {
                        errorMessage = error
                    }
                }
            }
            .buttonStyle(.borderedProminent)
            
            NavigationLink("Don't have an account? Sign Up") {
                SignupView()
            }
            .foregroundColor(.blue)
        }
        .padding()
    }
}

#Preview {
    LoginView()
        .environmentObject(AuthViewModel())
}
