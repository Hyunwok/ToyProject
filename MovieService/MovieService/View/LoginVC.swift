import UIKit
import FirebaseAuth
import RxSwift

class LoginVC: UIViewController {
    
    @IBOutlet weak var logInIdTextField: UITextField!
    @IBOutlet weak var logInPwTextField: UITextField!
    @IBOutlet weak var logInBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func getLogin(_ sender: UIButton) {
        if (logInPwTextField.text!.isEmpty || logInIdTextField.text!.isEmpty) {
            self.presentAlert(title: "로그인 실패", message: "아이디 혹은 비밀번호가 비어있습니다.")
        } else {
            Auth.auth().signIn(withEmail: logInIdTextField!.text!, password: logInPwTextField!.text!)
//            self.presentVC(identifier: "TabBarVC")
            guard let vc:MainPageVC = self.controller(name: StorybardName(rawValue: StorybardName.main.rawValue)!) else { return }
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func getRegister(_ sender: UIButton) {
        self.presentVC(identifier: "RegisterVC")
    }
}
