//
//  RegisterViewViewModel.swift
//  TwitterClone
//
//  Created by PC on 17.08.2024.
//

import Foundation
import Firebase
import Combine

final class RegisterViewViewModel:ObservableObject{
    //eklenen yenilikleri view da kullanicinin gormesini saglar.
    @Published var email:String?  //publisher:dinleyicidir, değişikliklerini yayınlar.
    @Published var password:String?
    @Published var isRegistrationFormValid:Bool = false
    @Published var user:User?
    
    private var subscriptions: Set<AnyCancellable> = []
    
    func ValidateRegistrationForm(){
        guard let email = email,
              let password = password else {
            isRegistrationFormValid = false
            return
        }
        isRegistrationFormValid = isValidEmail(email) && password.count >= 8
        
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    
    //yeni kullanici yaratma
    func createUser(){
        guard let email = email,
              let password  = password else {return}
        AuthManager.shared.registerUser(with: email, password: password).sink { _ in
            
        } receiveValue: { [weak self] user in
            self?.user = user
        }
        .store(in: &subscriptions) //abonelikleri saklamak ve yaşam döngüsünü yönetmek için kullanılır.

    }
    
    //var olan kullanici ile login olma.
    func loginUser(){
        guard let email = email,
              let password  = password else {return}
        AuthManager.shared.loginUser(with: email, password: password).sink { _ in
            
        } receiveValue: { [weak self] user in
            self?.user = user
        }
        .store(in: &subscriptions) //abonelikleri saklamak ve yaşam döngüsünü yönetmek için kullanılır.

    }
}
