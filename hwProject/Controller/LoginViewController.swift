//
//  LoginViewController.swift
//  hwProject
//
//  Created by 한철희 on 8/9/24.
//

import UIKit
import SnapKit
import Then
import RealmSwift

class LoginViewController: UIViewController {
    
    let emailTextField = UITextField().then {
        $0.placeholder = "email@example.com"
        $0.borderStyle = .roundedRect
        $0.font = UIFont.systemFont(ofSize: 16)
    }
    
    let passwordTextField = UITextField().then {
        $0.placeholder = "Password"
        $0.borderStyle = .roundedRect
        $0.isSecureTextEntry = true
        $0.font = UIFont.systemFont(ofSize: 16)
    }
    
    let loginButton = UIButton().then {
        $0.setTitle("로그인", for: .normal)
        $0.backgroundColor = UIColor.lightGray
        $0.setTitleColor(.black, for: .normal)
        $0.layer.cornerRadius = 5
        $0.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
    }
    
    let registerButton = UIButton().then {
        $0.setTitle("회원가입", for: .normal)
        $0.setTitleColor(.blue, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        $0.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }
    
    let showUsersButton = UIButton().then {
        $0.setTitle("등록된 사용자 보기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = UIColor.lightGray
        $0.layer.cornerRadius = 5
        $0.addTarget(self, action: #selector(showUsersButtonTapped), for: .touchUpInside)
    }
    
    let userManager = UserManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        clearTextFields()
        
        // 로그아웃 상태 확인
        if userManager.loggedInUser == nil {
            clearTextFields()
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(registerButton)
        view.addSubview(showUsersButton)
    }
    
    private func setupConstraints() {
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(100)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(40)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(emailTextField)
            $0.height.equalTo(40)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(50)
        }
        
        registerButton.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        showUsersButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(50)
        }
    }
    
    @objc func loginButtonPressed(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        
        if userManager.verifyUser(email: email, password: password) {
            userManager.setLoggedInUser(email: email)
            
            let homeViewController = HomeViewController(userManager: self.userManager)
            homeViewController.navigationItem.hidesBackButton = true
            self.navigationController?.pushViewController(homeViewController, animated: true)
            self.navigationController?.setNavigationBarHidden(true, animated: false)
        } else {
            showAlert(message: "이메일 또는 비밀번호가 잘못되었습니다.")
        }
    }
    
    @objc func registerButtonTapped(_ sender: Any) {
        let registerViewController = RegisterViewController()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.pushViewController(registerViewController, animated: true)
    }
    
    @objc func showUsersButtonTapped(_ sender: Any) {
        userManager.printAllUsers()
    }
    
    private func clearTextFields() {
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
