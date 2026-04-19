//
//  DogBreedAppApp.swift
//  DogBreedApp
//
//  Created by Heather Nichols on 4/2/26.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct DogBreedAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var viewModel = BreedViewModel()
    @StateObject var authVM = AuthViewModel()
    @AppStorage("hasSeenIntro") var hasSeenIntro: Bool = false

    var body: some Scene {
        WindowGroup {
            Group {
                if !hasSeenIntro {
                    NavigationStack {
                        IntroView {
                            hasSeenIntro = true
                        }
                    }
                } else if !authVM.isLoggedIn {
                    NavigationStack {
                        LoginView()
                    }
                } else {
                    NavigationStack {
                        FilterView()
                            .toolbar {
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    Button("Logout") {
                                        authVM.logout()
                                    }
                                }
                            }
                    }
                }
            }
            .environmentObject(viewModel)
            .environmentObject(authVM)
        }
    }
}
