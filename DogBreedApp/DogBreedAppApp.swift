//
//  DogBreedAppApp.swift
//  DogBreedApp
//
//  Created by Heather Nichols on 4/2/26.
//

import SwiftUI

@main
struct DogBreedAppApp: App {
    
    @StateObject var viewModel = BreedViewModel()
    @AppStorage("hasSeenIntro") var hasSeenIntro: Bool = false
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if hasSeenIntro {
                    FilterView()
                } else {
                    IntroView {
                        hasSeenIntro = true
                    }
                }
            }
            .environmentObject(viewModel)
        }
    }
}
