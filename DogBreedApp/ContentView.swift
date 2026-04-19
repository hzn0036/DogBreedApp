//
//  ContentView.swift
//  DogBreedApp
//
//  Created by Heather Nichols on 4/2/26.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @EnvironmentObject var authVM: AuthViewModel
    
    var body: some View {
        BreedListView()
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Logout") {
                        authVM.logout()
                    }
                }
            }
    }
}

#Preview {
    ContentView()
        .environmentObject(BreedViewModel())
        .environmentObject(AuthViewModel())
}

