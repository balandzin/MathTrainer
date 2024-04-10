//
//  ViewController.swift
//  MathTrainer
//
//  Created by Антон Баландин on 22.02.24.
//

import UIKit

enum MathTypes: Int, CaseIterable {
    case add, subtract, multiply, divide
    
    var key: String {
        switch self {
        case .add:
            "addCount"
        case .subtract:
            "subtractCount"
        case .multiply:
            "multiplyCount"
        case .divide:
            "divideCount"
        }
    }
}

final class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var buttonCollection: [UIButton]!
    
    @IBOutlet var addCountLabel: UILabel!
    @IBOutlet var subtractCountLabel: UILabel!
    @IBOutlet var multiplyCountLabel: UILabel!
    @IBOutlet var divideCountLabel: UILabel!
    
    
    // MARK: - Properties
    private var selectedType: MathTypes = .add
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureButton()
        setCountLabels()
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
    
    @IBAction func unwindAction(unwindSegue: UIStoryboardSegue) {
        setCountLabels()
    }
    
    @IBAction func clearAction(_ sender: Any) {
        MathTypes.allCases.forEach { type in
            let key = type.key
            UserDefaults.standard.removeObject(forKey: key)
            addCountLabel.text = "-"
            subtractCountLabel.text = "-"
            multiplyCountLabel.text = "-"
            divideCountLabel.text = "-"
        }
        
    }
    
    
    // MARK: - Methods
    private func setCountLabels() {
        MathTypes.allCases.forEach { type in
            let key = type.key
            guard let count = UserDefaults.standard.object(forKey: key) as? Int else { return }
            
            switch type {
            case .add:
                addCountLabel.text = "\(count)"
            case .subtract:
                subtractCountLabel.text = String(count)
            case .multiply:
                multiplyCountLabel.text = String(count)
            case .divide:
                divideCountLabel.text = String(count)
            }
        }
    }
    
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
