//
//  HomeView.swift
//  hwProject
//
//  Created by 한철희 on 8/10/24.
//

import UIKit
import SnapKit
import Then

class HomeView: UIViewController {
    
    // UILabel
    let welcomeLabel = UILabel().then {
        $0.text = "환영합니다"
        $0.font = UIFont.systemFont(ofSize: 24)
        $0.textAlignment = .center
    }
    
    // UIButton
    let logoutButton = UIButton().then {
        $0.setTitle("로그아웃", for: .normal)
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
        
        // Add subviews
        view.addSubview(welcomeLabel)
        view.addSubview(logoutButton)
    }
    
    private func setupConstraints() {
        // Welcome label constraints
        welcomeLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-20)
        }
        
        // Logout button constraints
        logoutButton.snp.makeConstraints {
            $0.top.equalTo(welcomeLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(50)
        }
    }
}
