//
//  RegisterViewController.swift
//  hwProject
//
//  Created by 한철희 on 8/9/24.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var pwCheckTextField: UITextField!
    @IBOutlet weak var wrongPWText: UILabel!
    
    @IBOutlet weak var registerButton: UIButton!
    @IBAction func registerButtonClicked(_ sender: Any) {
        print("가입완료")
        // LoginView로 돌아가기
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


}
