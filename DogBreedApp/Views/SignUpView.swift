//
//  SignUpView.swift
//  DogBreedApp
//
//  Created by Heather Nichols on 4/13/26.
//

import SwiftUI

struct SignupView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            Text("🐶")
                .font(.system(size: 120))
            Text("Create Account")
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
            
            Button("Sign Up") {
                authVM.signUp(email: email, password: password) { error in
                    if let error = error {
                        errorMessage = error
                    }
                }
            }
            .buttonStyle(.borderedProminent)
            
            Button("Already have an account? Login") {
                dismiss()
            }
            .foregroundColor(.blue)
        }
        .padding()
    }
}

#Preview {
    SignupView()
        .environmentObject(AuthViewModel())
}
