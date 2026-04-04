//
//  BreedViewModel.swift
//  DogBreedApp
//
//  Created by Heather Nichols on 4/2/26.
//

import Foundation
import Combine

class BreedViewModel: ObservableObject {
    @Published var breeds: [BreedModel] = []
    @Published var isLoading = false
    @Published var hasError = false
    @Published var breedError: BreedError?
    
    @MainActor
    func fetchBreeds(forceReload: Bool = false) async {
        if forceReload {
            self.breeds.removeAll()
        }
        
        guard breeds.isEmpty else { return }
        
        self.isLoading = true
        self.hasError = false
        self.breedError = nil
        
        let baseUrl = "https://api.thedogapi.com/v1/breeds"
        let apiKey = "live_lCJLfEjbJg02NtyMR71TcmOBEuOCnkN6RXx5W70viqwppKCY5F1xXUIbkth52wim"
        
        guard let url = URL(string: baseUrl) else {
            self.isLoading = false
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoded = try JSONDecoder().decode([BreedModel].self, from: data)
            self.breeds = decoded
            self.isLoading = false
        } catch {
            self.hasError = true
            self.breedError = .customError(error: error)
            self.isLoading = false
        }
    }
    
    enum BreedError: LocalizedError {
        case customError(error: Error)
        
        var errorDescription: String? {
            switch self {
            case .customError(let error):
                return error.localizedDescription
            }
        }
    }
}
