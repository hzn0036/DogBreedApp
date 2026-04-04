//
//  BreedDetailView.swift
//  DogBreedApp
//
//  Created by Heather Nichols on 4/2/26.
//

import SwiftUI

struct BreedDetailView: View {
    var breed: BreedModel
    var body: some View {
    ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                AsyncImage(url: URL(string: breed.image?.url ?? "")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    Color.gray.opacity(0.3)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 300)
                .clipped()
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(breed.name)
                        .lineLimit(nil)
                        .font(.title)
                        .fontWeight(.bold)
                      
                    
                    if let breedGroup = breed.breedGroup {
                        Text(breedGroup)
                            .lineLimit(nil)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            
                    }
                    
                    if let origin = breed.origin, !origin.isEmpty {
                        Text("Origin: \(origin)")
                            
                    }

                    if let lifeSpan = breed.lifeSpan, !lifeSpan.isEmpty {
                        Text("Life Span: \(lifeSpan)")
                           
                    }

                    if let temperament = breed.temperament, !temperament.isEmpty {
                        Text("Temperament: \(temperament)")
                            
                    }

                    if let weight = breed.weight {
                        Text("Weight: \(weight.imperial ?? "N/A") lbs")
                            
                    }

                    if let height = breed.height {
                        Text("Height: \(height.imperial ?? "N/A") in")
                            
                    }

                    if let description = breed.description, !description.isEmpty {
                        Text(description)
                            .padding(.top, 4)
                           
                    }

                    if let history = breed.history, !history.isEmpty {
                        Text("History")
                            .font(.headline)
                            .padding(.top, 8)
                        
                        Text(history)
                            
                    }
                }
                .padding(.top)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
            }
        }
        .navigationTitle(breed.name)
        .navigationBarTitleDisplayMode(.inline)
    }

}
#Preview {
    BreedDetailView(breed: BreedModel(
        id: "1",
        name: "Akita",
        lifeSpan: "10-15 years",
        temperament: "Independent, protective, calm, alert, loyal, courageous, and sometimes wary of strangers.",
        origin: "Japan",
        description: "A large and powerful dog breed known for its independent nature, strong protective instincts, and loyalty to its family. It is intelligent and can be quite stubborn at times.",
        breedGroup: "Working",
        weight: MeasurementModel(imperial: "70-130", metric: "32-59"),
        height: MeasurementModel(imperial: "24-28", metric: "61-71"),
        image: BreedImageModel(id: nil, url: "", width: nil, height: nil)
    ))
}
