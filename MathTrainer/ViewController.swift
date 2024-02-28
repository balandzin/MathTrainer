//
//  ViewController.swift
//  MathTrainer
//
//  Created by Антон Баландин on 22.02.24.
//

import UIKit

enum MathTypes: Int {
    case add, subtract, multiply, divide
}

final class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var buttonCollection: [UIButton]!
    
    // MARK: - Properties
    private var selectedType: MathTypes = .add
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureButton()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? TrainViewController {
            viewController.type = selectedType
        }
    }
    
    // MARK: - Actions
    @IBAction func buttonAction(_ sender: UIButton) {
        selectedType = MathTypes(rawValue: sender.tag) ?? .add
        
        performSegue(withIdentifier: "GoToNext", sender: sender)
    }
    
    @IBAction func unwindAction(unwindSegue: UIStoryboardSegue) {}
    
    // MARK: - Methods
    private func configureButton() {
        // Add shadow
        buttonCollection.forEach { button in
            button.layer.shadowColor = UIColor.darkGray.cgColor
            button.layer.shadowOffset = CGSize(width: 0, height: 2)
            button.layer.shadowOpacity = 0.4
            button.layer.shadowRadius = 3
        }
    }
}
