//
//  OnboardingViewController.swift
//  TwitterClone
//
//  Created by PC on 16.07.2024.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    private let welcomeLabel:UILabel = {
        let label = UILabel()
        label.text = "Welcome to swift life"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 30, weight: .heavy)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .label
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(welcomeLabel)
        ConfigureConstraints()

    }
    
    private func ConfigureConstraints() {
        let welcomeConstraints = [
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -20),
            welcomeLabel.heightAnchor.constraint(equalToConstant: 30),
            welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        
        ]
        NSLayoutConstraint.activate(welcomeConstraints)
    }
    

  
}
