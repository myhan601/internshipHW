//
//  RegisterViewController.swift
//  hwProject
//
//  Created by 한철희 on 8/9/24.
//

import UIKit
import SnapKit
import Then

class RegisterViewController: UIViewController {

    // UI 요소들
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
        $0.isUserInteractionEnabled = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupActions()
    }

    private func setupUI() {
        view.backgroundColor = .white
        
        // UI 요소들을 뷰에 추가
        view.addSubview(titleLabel)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(registerButton)
    }
    
    private func setupConstraints() {
        // UI 요소들의 제약 조건 설정
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

    private func setupActions() {
        // 버튼 액션 설정
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }

    @objc private func registerButtonTapped() {
        print("Register button tapped")
        
        // 이메일 유효성 검사
        guard let email = emailTextField.text, isValidEmail(email) else {
            showAlert(message: "유효한 이메일을 입력하세요.")
            return
        }

        // 비밀번호 유효성 검사
        guard let password = passwordTextField.text, isValidPassword(password) else {
            showAlert(message: "비밀번호는 6자리 이상이어야 합니다.")
            return
        }

        // 로컬에 사용자 데이터 저장
        saveUserData(email: email, password: password)
    }

    private func isValidEmail(_ email: String) -> Bool {
        // 이메일 유효성 검사 로직 (간단한 정규식 사용)
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format:"SELF MATCHES %@", emailRegEx).evaluate(with: email)
    }

    private func isValidPassword(_ password: String) -> Bool {
        // 비밀번호 유효성 검사 (예: 6자리 이상)
        return password.count >= 6
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    private func saveUserData(email: String, password: String) {
        // UserDefaults에 데이터 저장
        let defaults = UserDefaults.standard
        defaults.set(email, forKey: "userEmail")
        defaults.set(password, forKey: "userPassword")
        
        // 저장 완료 알림
        showAlert(message: "회원가입에 성공했습니다.")

        // 이전 화면으로 돌아가기
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
