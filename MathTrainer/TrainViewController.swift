//
//  TrainViewController.swift
//  MathTrainer
//
//  Created by Антон Баландин on 25.02.24.
//

import UIKit

final class TrainViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet var leftButton: UIButton!
    @IBOutlet var rightButton: UIButton!
    @IBOutlet var questionLabel: UILabel!
    
    
    //MARK: - Properties
    var type: MathTypes = .add
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        configureButton()
    }
    
    // MARK: - Methods
    private func configureButton() {
        // Add shadow
        [leftButton, rightButton].forEach { button in
            button.layer.shadowColor = UIColor.darkGray.cgColor
            button.layer.shadowOffset = CGSize(width: 0, height: 2)
            button.layer.shadowOpacity = 0.4
            button.layer.shadowRadius = 3
        }
    }
}
