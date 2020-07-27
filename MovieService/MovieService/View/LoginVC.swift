import UIKit
import Firebase
import RxSwift
import Alamofire

class LoginVC: UIViewController {
    
    let viewModel = MovieViewModel()
    
    @IBOutlet weak var logInIdTextField: UITextField!
    @IBOutlet weak var logInPwTextField: UITextField!
    @IBOutlet weak var logInBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func getLogin(_ sender: UIButton) {
        if (logInPwTextField.text!.isEmpty || logInIdTextField.text!.isEmpty) {
            self.presentAlert(title: "로그인 실패", message: "아이디 혹은 비밀번호가 비어있습니다.")
        } else {
            Auth.auth().signIn(withEmail: logInIdTextField!.text!, password: logInPwTextField!.text!)
            self.presentVC(identifier: "TabBarVC")
        }
    }
    
    @IBAction func getRegister(_ sender: UIButton) {
        self.pushVC(identifier: "RegisterVC")
        //self.presentVC(identifier: "RegisterVC")
    }
}
