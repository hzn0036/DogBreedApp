//
//
//  DogBreedApp
//
//  Created by Heather Nichols on 4/2/26.
//

import SwiftUI

struct FilterView: View {
    
    @EnvironmentObject var viewModel: BreedViewModel
    
    let filterTypes = ["Breed Group", "Weight", "Alphabetical"]
    let breedGroups = ["All", "Toy", "Herding", "Working", "Hound", "Sporting", "Non-Sporting", "Terrier"]
    let weight = ["Small", "Medium", "Large"]
    let alphabet = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    
    @State var selectedFilterType = "Breed Group"
    @State var selectedGroup = "All"
    @State var selectedWeight = "Small"
    @State var selectedLetter = "A"
    
    var body: some View {
        VStack(spacing: 32) {
            Text("Filter By")
                .font(.headline)
            
            Picker("Filter By", selection: $selectedFilterType) {
                ForEach(filterTypes, id: \.self) { type in
                    Text(type).tag(type)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            
            if selectedFilterType == "Breed Group" {
                Picker("Breed Group", selection: $selectedGroup) {
                    ForEach(breedGroups, id: \.self) { group in
                        Text(group).tag(group)
                    }
                }
                .pickerStyle(.wheel)
                .frame(height: 150)
            } else if selectedFilterType == "Weight" {
                Picker("Weight", selection: $selectedWeight) {
                    ForEach(weight, id: \.self) { weight in
                        Text(weight).tag(weight)
                    }
                }
                .pickerStyle(.wheel)
                .frame(height: 150)
            } else {
                Picker("Letter", selection: $selectedLetter) {
                    ForEach(alphabet, id: \.self) { letter in
                        Text(letter).tag(letter)
                    }
                }
                .pickerStyle(.wheel)
                .frame(height: 150)
            }
            
            NavigationLink(destination: BreedListView(
                selectedGroup: selectedGroup,
                selectedWeight: selectedWeight,
                selectedLetter: selectedLetter,
                filterType: selectedFilterType
            ).environmentObject(viewModel)) {
                Text("Search")
                    .font(.headline)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(Color.blue)
                    .foregroundStyle(.white)
                    .padding(.horizontal)
            }
            
            Spacer()
        }
        .navigationTitle("Find a Breed")
        .task {
            await viewModel.fetchBreeds()
        }
    }
}

#Preview {
    NavigationStack {
        FilterView()
    }
    .environmentObject(BreedViewModel())
}
