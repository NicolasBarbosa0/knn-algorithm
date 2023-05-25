//
//  ViewController.swift
//  knn
//
//  Created by Nicolas Barbosa on 11/05/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let knn = KNN(splitedDataset: ([Iris](), [Iris]()), k: 5)
              let irisDataset = Iris.loadData() // Assuming you have a method to load the Iris dataset
              let trainingFactor = 0.7 // Training data percentage (70%)
              let dataset = knn.splitDataset(irisDataset, trainingFactor: trainingFactor)
              
              func printKNN() {
                  let knn = KNN(splitedDataset: dataset, k: 3)
                  print("Training dataset lenght: \(dataset.0.count)")
                  print("Test dataset lenght: \(dataset.1.count)")
                  print("Percentage: \(knn.validate(testDataset: dataset.1))")
              }
        printKNN()
    }

}

