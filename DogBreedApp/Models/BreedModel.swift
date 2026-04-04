//
//  BreedModel.swift
//  DogBreedApp
//
//  Created by Heather Nichols on 4/2/26.
//

import Foundation

struct BreedModel: Codable, Identifiable {
    var id: String
    var name: String
    var lifeSpan: String?
    var temperament: String?
    var origin: String?
    var description: String?
    var history: String?
    var breedGroup: String?
    var weight: MeasurementModel?
    var height: MeasurementModel?
    var image: BreedImageModel?
    
    enum CodingKeys: String, CodingKey {
        case id, name, origin, description, history, image, temperament, weight, height
        case lifeSpan = "life_span"
        case breedGroup = "breed_group"
    }
}

struct MeasurementModel: Codable {
    var imperial: String?
    var metric: String?
}

struct BreedImageModel: Codable {
    var id: String?
    var url: String?
    var width: Int?
    var height: Int?
}
