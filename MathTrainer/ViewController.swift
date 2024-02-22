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

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var buttonCollection: [UIButton]!
    
    // MARK: - Properties
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureButton()
    }
    
    // MARK: - Actions
    @IBAction func buttonAction(_ sender: UIButton) {
        
    }
    
    
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

