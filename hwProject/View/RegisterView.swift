//
//  RegisterView.swift
//  hwProject
//
//  Created by 한철희 on 8/10/24.
//

import UIKit
import SnapKit
import Then

class RegisterView: UIViewController {
    
    
    let titleLabel = UILabel().then {
        $0.text = "회원가입"
        $0.font = UIFont.boldSystemFont(ofSize: 24)
        $0.textAlignment = .center
    }
    
    let emailLabel = UILabel().then {
        $0.text = "이메일"
        $0.font = UIFont.systemFont(ofSize: 16)
    }
    
    let passwordLabel = UILabel().then {
        $0.text = "비밀번호"
        $0.font = UIFont.systemFont(ofSize: 16)
    }
    
    let emailTextField = UITextField().then {
        $0.placeholder = "email@example.com"
        $0.borderStyle = .roundedRect
        $0.font = UIFont.systemFont(ofSize: 16)
    }
    
    let passwordTextField = UITextField().then {
        $0.placeholder = "PW"
        $0.borderStyle = .roundedRect
        $0.isSecureTextEntry = true
        $0.font = UIFont.systemFont(ofSize: 16)
    }
    
    let registerButton = UIButton().then {
        $0.setTitle("가입하기", for: .normal)
        $0.backgroundColor = UIColor.lightGray
        $0.setTitleColor(.black, for: .normal)
        $0.layer.cornerRadius = 5
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(registerButton)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            $0.centerX.equalToSuperview()
        }
        
        emailLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(20)
        }
        
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(emailLabel.snp.bottom).offset(8)
            $0.leading.equalTo(emailLabel)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(40)
        }
        
        passwordLabel.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(20)
            $0.leading.equalTo(emailTextField)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordLabel.snp.bottom).offset(8)
            $0.leading.equalTo(passwordLabel)
            $0.trailing.equalTo(emailTextField)
            $0.height.equalTo(40)
        }
        
        registerButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(50)
        }
    }
}
