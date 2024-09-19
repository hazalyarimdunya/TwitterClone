//
//  RegisterViewController.swift
//  TwitterClone
//
//  Created by PC on 19.07.2024.
//

import UIKit
import Combine

class RegisterViewController: UIViewController {
    
    private var viewModel = RegisterViewViewModel()
    private var subscriptions: Set<AnyCancellable> = []
    
    private let titleLabel:UILabel = {
        let label = UILabel()
        label.text = "Create your account"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .heavy)
        label.textColor = .label

        return label
    }()
    private let emailTextField:UITextField = {
        let textField = UITextField()
        textField.placeholder = "E-mail"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .systemFont(ofSize: 20, weight: .regular)
        textField.keyboardType = .emailAddress
        return textField
    }()
    private let passwordTextField:UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .systemFont(ofSize: 20, weight: .regular)
        textField.isSecureTextEntry = true
        return textField
    }()
    private let registerAccountButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Register", for: .normal)
        button.layer.cornerRadius = 30
        button.layer.masksToBounds = true
        button.backgroundColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        button.tintColor = .white
        button.isEnabled = false
        return button
        
    }()
    
    private func bindViews(){
        emailTextField.addTarget(self, action: #selector(didChagneEmailField), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(didChangePasswordField), for: .editingChanged)
        viewModel.$isRegistrationFormValid.sink { [weak self] validationState in
            self?.registerAccountButton.isEnabled = validationState
        }
        .store(in: &subscriptions)
        
        viewModel.$user.sink { [weak self] user in
            print(user)
        }
        .store(in: &subscriptions)
    }
    @objc private func didChagneEmailField(){
        viewModel.email = emailTextField.text
        viewModel.ValidateRegistrationForm()
        
    }
    @objc private func didChangePasswordField(){
        viewModel.password = passwordTextField.text
        viewModel.ValidateRegistrationForm()
    }
    @objc private func didTopToDismiss(){
        view.endEditing(true)
    }
    
    @objc private func didTopRegister(){
        viewModel.createUser()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(titleLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(registerAccountButton)
        ConfigureConstraints()
        //klavye bos yere tiklaninca kapanir.
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTopToDismiss)))
        bindViews()
        registerAccountButton.addTarget(self, action: #selector(didTopRegister),for : .touchUpInside)

    }
    
    private func ConfigureConstraints(){
        let titleLabelConstrains = [
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ]
        let emailConstraints = [
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40)
        ]
        let passwordConstraints = [
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 40)
        ]
        let registerAccountConstraints = [
            registerAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerAccountButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            registerAccountButton.widthAnchor.constraint(equalTo: titleLabel.widthAnchor, constant: 80),
            registerAccountButton.heightAnchor.constraint(equalToConstant: 60)
        ]
        
        NSLayoutConstraint.activate(titleLabelConstrains)
        NSLayoutConstraint.activate(emailConstraints)
        NSLayoutConstraint.activate(passwordConstraints)
        NSLayoutConstraint.activate(registerAccountConstraints)
    }
    
}
