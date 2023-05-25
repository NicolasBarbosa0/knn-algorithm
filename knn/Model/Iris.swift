//
//  Iris.swift
//  knn
//
//  Created by Nicolas Barbosa on 15/05/23.
//

import Foundation

/// Data Object refering to Iris dataset.
struct Iris: Decodable {
    var id: Int
    var sepalLenght: Double
    var sepalWidth: Double
    var petalLenght: Double
    var petalWidth: Double
    let species: String
    /// SIMD (Single Instruct Multiple Data) containing all atributes used to predict a Iris species.
    var vector: SIMD4<Double>? {
        return SIMD4(sepalLenght, sepalWidth, petalLenght, petalWidth)
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case sepalLenght = "SepalLengthCm"
        case sepalWidth = "SepalWidthCm"
        case petalLenght = "PetalLengthCm"
        case petalWidth = "PetalWidthCm"
        case species = "Species"
    }
    
    static func loadData() -> [Iris] {
        guard let url = Bundle.main.url(forResource: "Iris", withExtension: ".json") else { return [] }
        do {
            let binaryData = try Data(contentsOf: url)
            var irisData = try JSONDecoder().decode([Iris].self, from: binaryData)
            irisData.shuffle()
            return irisData
        }
        catch {
            print(error)
        }
        return []
    }
    
  
}
