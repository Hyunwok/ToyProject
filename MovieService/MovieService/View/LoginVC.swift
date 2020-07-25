import UIKit
import Firebase
import RxSwift
import Alamofire

class LoginVC: UIViewController {
    
    let viewModel = MovieViewModel()
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var logInIdTextField: UITextField!
    @IBOutlet weak var logInPwTextField: UITextField!
    @IBOutlet weak var logInBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func getLogin(_ sender: UIButton) {
        if ((logInPwTextField.text?.isEmpty) != nil || ((logInIdTextField.text?.isEmpty) != nil)) {
            Auth.auth().signIn(withEmail: logInIdTextField!.text!, password: logInPwTextField!.text!)
            self.presentVC(identifier: "MainPageVC")
        }
        self.presentAlert(title: "로그인 실패", message: "아이디 혹은 비밀번호가 비어있습니다.")
    }
    
    @IBAction func getRegister(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterVC") else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


extension UIViewController {
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func presentVC(identifier: String) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: identifier) else { return }
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}
