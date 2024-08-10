//
//  HomeViewController.swift
//  hwProject
//
//  Created by 한철희 on 8/9/24.
//

import UIKit
import SnapKit
import Then

class HomeViewController: UIViewController {

    // UI Elements
    let welcomeLabel = UILabel().then {
        $0.text = "환영합니다"
        $0.font = UIFont.systemFont(ofSize: 24)
        $0.textAlignment = .center
    }
    
    let logoutButton = UIButton().then {
        $0.setTitle("로그아웃", for: .normal)
        $0.backgroundColor = UIColor.lightGray
        $0.setTitleColor(.black, for: .normal)
        $0.layer.cornerRadius = 5
        $0.addTarget(self, action: #selector(logoutButtonPressed), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        
        logoutButton.addTarget(self, action: #selector(logoutButtonPressed), for: .touchUpInside)
    }
    
    // UI Setup
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(welcomeLabel)
        view.addSubview(logoutButton)
    }
    
    private func setupConstraints() {
        welcomeLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-20)
        }
        
        logoutButton.snp.makeConstraints {
            $0.top.equalTo(welcomeLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(50)
        }
    }
    
    // Button Actions
    @objc func logoutButtonPressed(_ sender: Any) {
        // 로그아웃하고 LoginView로 돌아가기
        let loginViewController = LoginViewController()
        
        loginViewController.modalPresentationStyle = .fullScreen
        self.present(loginViewController, animated: true, completion: nil)
    }
}
