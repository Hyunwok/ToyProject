import UIKit
import Alamofire

// MARK: LoginVC

class LoginVC: UIViewController {
    
    let ud = UserDefaults.standard

    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var findIdBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var autoLoginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logIn(_ sender: UIButton) {
        if idTextField.text!.isEmpty || pwTextField.text!.isEmpty {
            presentAlert(title: "로그인 실패", message: "아이디 혹은 비밀번호가 비었습니다.")
            return
        } else {
            serverLogin()
        }
    }
    
    @IBAction func autoLogin(_ sender: UIButton) {
        if idTextField.text!.isEmpty || pwTextField.text!.isEmpty {return }
        if sender.isSelected == true {
            ud.set(idTextField.text, forKey: "id")
            ud.set(pwTextField.text, forKey: "pw")
        } else {
            ud.removeObject(forKey: "id")
            ud.removeObject(forKey: "pw")
        }
        sender.isSelected = !sender.isSelected
    }
    
    func serverLogin() {
        let param = ["id":idTextField.text,"passwd":pwTextField.text] 
        AF.request("https://jsonplaceholder.typicode.com/posts", method: .post , parameters: param).responseJSON {
            (response) in
            switch response.result {
            case .success(_): self.presentVC()
            default: self.presentAlert(title: "error", message:"")
            }
        }
    }
}

// MARK: Extension

extension LoginVC {
    
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func presentVC() {
        guard let vc = storyboard?.instantiateViewController(identifier: "MainVC") as? MainVC else { return }
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Show the Navigation Bar
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

