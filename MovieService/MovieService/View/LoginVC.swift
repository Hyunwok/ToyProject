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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = animated
    }
    
    @IBAction func getLogin(_ sender: UIButton) {
        if (logInPwTextField.text!.isEmpty || logInIdTextField.text!.isEmpty) {
            self.presentAlert(title: "로그인 실패", message: "아이디 혹은 비밀번호가 비어있습니다.")
        } else {
            Auth.auth().signIn(withEmail: logInIdTextField!.text!, password: logInPwTextField!.text!) { [weak self] authResult, error in
                guard self != nil else { return }
                if error == nil { self?.presentAlert(title: "로그인 실패", message: "에러가 발생함"); return }
            }
        }
    }
    
    @IBAction func getRegister(_ sender: UIButton) {
        guard let vc: RegisterVC = self.controller(storyBoardName: "Main", name: .register) else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
