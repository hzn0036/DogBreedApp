//
//  ContentView.swift
//  DogBreedApp
//
//  Created by Heather Nichols on 4/2/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        BreedListView()
    }
}

#Preview {
    ContentView()
        .environmentObject(BreedViewModel())
}
