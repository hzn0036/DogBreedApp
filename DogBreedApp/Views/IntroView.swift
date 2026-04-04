//
//  IntroView.swift
//  DogBreedApp
//
//  Created by Heather Nichols on 4/2/26.
//

import SwiftUI

struct IntroView: View {
    
    var onFinish: () -> Void = { }
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Text("🐶")
                .font(.system(size: 100))
            
            Text("DogBreed Explorer")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Text("Discover hundreds of dog breeds from around the world")
                .font(.title3)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
                .padding(.horizontal)
            
            Spacer()
            
            Button(action: {
                onFinish()
            }) {
                Text("Start Exploring")
                    .font(.headline)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(Color.blue)
                    .foregroundStyle(.white)
            }
            .padding(.horizontal)
            .padding(.bottom, 40)
        }
    }
}

#Preview {
    IntroView()
}
