//
//  KNN.swift
//  knn
//
//  Created by Nicolas Barbosa on 12/05/23.


import Foundation
import simd


class KNN {
    
    public func splitDataset(_ dataset: [Iris], trainingFactor: Double) -> ([Iris], [Iris]) {
        var trainingData = [Iris]()
        var testData = [Iris]()
        let trainingLenght = Int(CGFloat(dataset.count) * trainingFactor)
        for i in 0..<trainingLenght { trainingData.append(dataset[i]) }
        for i in trainingLenght..<dataset.count { testData.append(dataset[i]) }
        return (trainingData, testData)

    }

    var splitedDataset: ([Iris], [Iris])
    var trainingData: [Iris] = [Iris]()
    var k: Int
    
    init(splitedDataset: ([Iris], [Iris]), k: Int) {
        self.splitedDataset = splitedDataset
        self.k = k
    }
    
    func train() { for trainingElement in splitedDataset.0 { trainingData.append(trainingElement) } }
    
    func predict(_ testInstance: SIMD4<Double>) -> String {
    var distances: [(Iris, Double)] = []
        
        for i in 0..<trainingData.count {
            let distance = simd_distance(testInstance, trainingData[i].vector!)
            distances.append((trainingData[i], distance))
        }
        
        distances = distances.sorted(by: { $0.1 < $1.1 })
        
        var neighbours: [Iris] = []
        for i in 0..<k { neighbours.append(distances[i].0) }
        
        let countSpecies = [
            "Iris-setosa": neighbours.filter { $0.species == "Iris-setosa"}.count,
            "Iris-versicolor": neighbours.filter { $0.species == "Iris-versicolor"}.count,
            "Iris-virginica": neighbours.filter { $0.species == "Iris-virginica"}.count
        ]
        
        return countSpecies.sorted(by: { $0.value > $1.value } ).first!.key
    }
    
    func validate(testDataset: [Iris]) -> Double {
        train()
        var hits = 0
        
        for testInstance in testDataset {
            let expect = testInstance.species
            let predict = predict(testInstance.vector!)
            if predict == expect { hits += 1 }
        }
        print(("Hits: \(hits)"))
        let percent = Double(CGFloat(hits)/CGFloat(testDataset.count))
        return percent
    }
    
}
