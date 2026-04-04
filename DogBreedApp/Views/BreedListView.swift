//
//  BreedListView.swift
//  DogBreedApp
//
//  Created by Heather Nichols on 4/2/26.
//

import SwiftUI

struct BreedListView: View {
    @EnvironmentObject var viewModel: BreedViewModel
    
    var selectedGroup: String = "All"
    var selectedWeight: String = "Small"
    var selectedLetter: String = "A"
    var filterType: String = "Breed Group"
    var searchText: String = ""
    
    let columns = [
        GridItem(.adaptive(minimum: 160), spacing: 16),
        GridItem(.adaptive(minimum: 160), spacing: 16)
    ]
    
    var filteredBreeds: [BreedModel] {
        var result = viewModel.breeds
        
        switch filterType {
        case "Breed Group":
            if selectedGroup != "All" {
                result = result.filter {
                    $0.breedGroup?.localizedCaseInsensitiveContains(selectedGroup) ?? false
                }
            }
        case "Weight":
            result = result.filter { breed in
                guard let imperial = breed.weight?.imperial else { return false }
                let parts = imperial.split(separator: "-")
                guard let max = parts.last, let maxWeight = Int(max.trimmingCharacters(in: .whitespaces)) else { return false }
                switch selectedWeight {
                case "Small": return maxWeight <= 25
                case "Medium": return maxWeight > 25 && maxWeight <= 60
                case "Large": return maxWeight > 60
                default: return true
                }
            }
        case "Alphabetical":
            result = result.filter {
                $0.name.hasPrefix(selectedLetter)
            }
        default:
            break
        }
        
        return result
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(filteredBreeds) { breed in
                    NavigationLink(destination: BreedDetailView(breed: breed)) {
                        VStack(alignment: .leading, spacing: 0) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 0)
                                    .fill(Color.gray.opacity(0.3))
                                
                                AsyncImage(url: URL(string: breed.image?.url ?? "")) { phase in
                                    switch phase {
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 160, height: 160)
                                            .clipped()
                                    case .failure(_):
                                        Image(systemName: "photo")
                                            .font(.largeTitle)
                                            .foregroundColor(.gray)
                                    case .empty:
                                        ProgressView()
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                            }
                            .frame(width: 160, height: 160)
                            .clipped()
                            
                            Text(breed.name)
                                .font(.headline)
                                .lineLimit(1)
                                .padding(8)
                                .frame(width: 160, alignment: .leading)
                        }
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
            }
            .padding(.horizontal)
        }
        .navigationTitle("Dog Breeds")
        .task {
            await viewModel.fetchBreeds()
        }
    }
}

#Preview {
    BreedListView()
        .environmentObject(BreedViewModel())
}
