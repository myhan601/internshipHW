//
//  LoginViewController.swift
//  hwProject
//
//  Created by 한철희 on 8/9/24.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailInputTextField: UITextField!
    @IBOutlet weak var pwInputTextField: UITextField!
    
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        // 로그인 성공 시 HomeView로
        // 이메일이 DB에 존재x -> 존재하지 않습니다 alert
        // 이메일이 DB에 존재o , 비밀번호가 틀리면? -> 비밀번호가 틀립니다 alert
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        // RegisterView로 이동
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
