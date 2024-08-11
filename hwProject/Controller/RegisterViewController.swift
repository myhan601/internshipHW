//
//  RegisterViewController.swift
//  hwProject
//
//  Created by 한철희 on 8/9/24.
//

import UIKit
import SnapKit
import Then
import RealmSwift

class RegisterViewController: UIViewController {
    
    let registerInputView = RegisterInputView()
    let userManager = UserManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(registerInputView)
        
        registerInputView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupActions() {
        registerInputView.registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }
    
    @objc private func registerButtonTapped() {
        print("Register button tapped")
        
        guard let email = registerInputView.emailTextField.text, isValidEmail(email) else {
            showAlert(message: "유효한 이메일을 입력하세요.")
            return
        }
        
        guard let password = registerInputView.passwordTextField.text, isValidPassword(password) else {
            showAlert(message: "비밀번호는 6자리 이상이어야 합니다.")
            return
        }
        
        // 이메일 중복 확인
        if userManager.isEmailRegistered(email) {
            showAlert(message: "이미 가입된 이메일입니다.")
            return
        }
        
        saveUserData(email: email, password: password)
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format:"SELF MATCHES %@", emailRegEx).evaluate(with: email)
    }
    
    private func isValidPassword(_ password: String) -> Bool {
        return password.count >= 6
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func saveUserData(email: String, password: String) {
        userManager.addUser(email: email, password: password)
        
        showAlert(message: "회원가입에 성공했습니다.")
        userManager.printAllUsers()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
