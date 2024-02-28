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
    @IBOutlet var countLabel: UILabel!
    
    
    //MARK: - Properties
    var type: MathTypes = .add {
        didSet {
            switch type {
            case .add:
                sign = "+"
            case .subtract:
                sign = "-"
            case .multiply:
                sign = "*"
            case .divide:
                sign = "/"
            }
        }
    }
    
    private var firstNumber = 0
    private var secondNumber = 0
    private var sign = ""
    private var count = 0 {
        didSet {
            print(count)
        }
    }
    
    private var answer: Int {
        switch type {
        case .add:
            return firstNumber + secondNumber
        case .subtract:
            return firstNumber - secondNumber
        case .multiply:
            return firstNumber * secondNumber
        case .divide:
            return firstNumber / secondNumber
        }
    }
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        configureQuestion()
        configureButton()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? ViewController {
            
            switch type {
            case .add:
                viewController.addLabel.text = String(count)
            case .subtract:
                viewController.subtractLabel.text = String(count)
            case .multiply:
                viewController.multiplyLabel.text = String(count)
            case .divide:
                viewController.divideLabel.text = String(count)
            }
        }
    }
    
    // MARK: - Actions
    
    @IBAction func leftAction(_ sender: UIButton) {
        check(answer: sender.titleLabel?.text ?? "", for: sender)
    }
    
    @IBAction func rightAction(_ sender: UIButton) {
        check(answer: sender.titleLabel?.text ?? "",  for: sender)
    }
    
    // MARK: - Methods
    private func configureButton() {
        let buttonsArray = [leftButton, rightButton]
        
        buttonsArray.forEach { button in
            button?.backgroundColor = .systemYellow
        }
        // Add shadow
        buttonsArray.forEach { button in
            button?.layer.shadowColor = UIColor.darkGray.cgColor
            button?.layer.shadowOffset = CGSize(width: 0, height: 2)
            button?.layer.shadowOpacity = 0.4
            button?.layer.shadowRadius = 3
            
            button?.titleLabel!.font = UIFont.boldSystemFont(ofSize: 20)
        }
        
        let isRightButton = Bool.random()
        
        var randomAnswer: Int
        repeat {
            randomAnswer = Int.random(in: (answer - 10)...(answer + 10))
        } while randomAnswer == answer
        
        rightButton.setTitle(
            isRightButton ? String(answer) : String(randomAnswer),
            for: .normal
        )
        
        leftButton.setTitle(
            isRightButton ? String(randomAnswer) : String(answer),
            for: .normal
        )
    }
    
    private func configureQuestion() {
        firstNumber = Int.random(in: 1...99)
        secondNumber = Int.random(in: 1...99)
        
        if type == .divide {
            while firstNumber % secondNumber != 0 {
                firstNumber = Int.random(in: 1...99)
                secondNumber = Int.random(in: 1...99)
            }
        }
        
        let question = "\(firstNumber) \(sign) \(secondNumber) = "
        
        questionLabel.text = question
    }
    
    private func check(answer: String, for button: UIButton) {
        let isRightAnswer = Int(answer) == self.answer
        
        button.backgroundColor = isRightAnswer ? .systemGreen : .systemRed
        
        let isSecondAttempt = rightButton.backgroundColor == .systemRed || leftButton.backgroundColor == .systemRed
        
        count += !isSecondAttempt ? 1 : 0
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.configureQuestion()
            self?.configureButton()
        }
        
        countLabel.text = "Ваш счет: \(count)"
    }
}
