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
    private let createAccountButton:UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Create Accocunt", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.backgroundColor = UIColor(red: 29/255, green: 161/255, blue: 242/155, alpha: 1)
        button.tintColor = .white
        button.layer.cornerRadius = 30
        button.layer.masksToBounds = true
        return button
    }()
    private let promptLabel:UILabel = {
        let label = UILabel()
        label.text = "Have an account already?"
        label.tintColor = .gray
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let loginButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.tintColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(welcomeLabel)
        view.addSubview(createAccountButton)
        view.addSubview(promptLabel)
        view.addSubview(loginButton)
        ConfigureConstraints()
        
        createAccountButton.addTarget(self, action: #selector(DidTopCreateAccountButton), for: .touchUpInside)

    }
    
    @objc private func DidTopCreateAccountButton() {
        let vc = RegisterViewController()
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    private func ConfigureConstraints() {
        let welcomeConstraints = [
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -20),
            welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        
        ]
        let createAccountButtonConstraints = [
            createAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createAccountButton.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 20),
            createAccountButton.widthAnchor.constraint(equalTo: welcomeLabel.widthAnchor, constant: -200),
            createAccountButton.heightAnchor.constraint(equalToConstant: 60)
        ]
        let promptLabelConstraints = [
            promptLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            promptLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70)
        ]
        let loginButtonConstraints = [
            loginButton.leadingAnchor.constraint(equalTo: promptLabel.trailingAnchor, constant: 10),
            loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70),
            loginButton.centerYAnchor.constraint(equalTo: promptLabel.centerYAnchor)
        ]
        NSLayoutConstraint.activate(welcomeConstraints)
        NSLayoutConstraint.activate(createAccountButtonConstraints)
        NSLayoutConstraint.activate(promptLabelConstraints)
        NSLayoutConstraint.activate(loginButtonConstraints)
    }
    

  
}
