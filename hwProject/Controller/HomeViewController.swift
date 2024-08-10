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
    
    let userManager: UserManager
    
    init(userManager: UserManager = UserManager()) {
        self.userManager = userManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    let resignButton = UIButton().then {
        $0.setTitle("탈퇴하기", for: .normal)
        $0.setTitleColor(.red, for: .normal)
        $0.addTarget(self, action: #selector(resignButtonPressed), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        updateWelcomeLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateWelcomeLabel()
    }
    
    private func updateWelcomeLabel() {
        if let loggedInUser = userManager.getLoggedInUser() {
            welcomeLabel.text = "환영합니다, \(loggedInUser.email)!"
        } else {
            welcomeLabel.text = "로그인된 사용자가 없습니다"
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(welcomeLabel)
        view.addSubview(logoutButton)
        view.addSubview(resignButton)
    }
    
    private func setupConstraints() {
        welcomeLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-40)
        }
        
        logoutButton.snp.makeConstraints {
            $0.top.equalTo(welcomeLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(50)
        }
        
        resignButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(logoutButton.snp.bottom).offset(20)
        }
    }
    
    @objc func logoutButtonPressed(_ sender: Any) {
        userManager.logoutUser()  // 로그아웃 처리
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
    
    @objc func resignButtonPressed(_ sender: Any) {
        guard userManager.loggedInUser != nil else {
            showAlert(message: "로그인된 사용자가 없습니다.")
            return
        }
        
        let alert = UIAlertController(title: "회원 탈퇴", message: "정말로 탈퇴하시겠습니까?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "확인", style: .destructive, handler: { [weak self] _ in
            guard let self = self else { return }
            
            if self.userManager.deleteLoggedInUser() {
                DispatchQueue.main.async {
                    if let loginVC = self.navigationController?.viewControllers.first(where: { $0 is LoginViewController }) {
                        self.navigationController?.popToViewController(loginVC, animated: true)
                    } else {
                        let loginVC = LoginViewController()
                        self.navigationController?.setViewControllers([loginVC], animated: true)
                    }
                }
            } else {
                self.showAlert(message: "사용자 삭제 중 오류가 발생했습니다.")
            }
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
