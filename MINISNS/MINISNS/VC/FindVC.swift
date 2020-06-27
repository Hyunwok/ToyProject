import UIKit
import Alamofire

// MARK: FindVC

class FindVC: WriteVC {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var findEmailTextField: UITextField!
    @IBOutlet weak var findIdPwBtn: UIButton!
    @IBOutlet weak var setIdPwSegment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        findEmailTextField.isHidden = true
    }
    
    @IBAction func changeIdPwView(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            findEmailTextField.isHidden = true
        default:
            findEmailTextField.isHidden = false
        }
    }
    
    @IBAction func getIdOrPw(_ sender: UIButton) {
        if setIdPwSegment.selectedSegmentIndex == 0 {
            let url = "http://10.156.145.141:3000/find/email"
            let param : [String:Any] = ["name": nameTextField.text!, "phone":phoneNumberTextField.text!]
            getIdOrPw(url: url, param: param, caseNum: 0)
        } else {
            let url = "http://10.156.145.141:3000/find/password"
            let param : [String:Any] = ["name":nameTextField.text!,
                                        "email":findEmailTextField.text!,
                                        "phone":phoneNumberTextField.text!]
            getIdOrPw(url: url, param: param, caseNum: 1)
        }
    }
}


// MARK: extension

extension FindVC {
    
    func getIdOrPw(url:String, param: [String:Any], caseNum: Int) {
        let name: String
        if caseNum == 0 { name = "email" } else { name = "password" }
        AF.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: ["Content-Type":"application/json"]).responseJSON {(response) in
            guard let status = response.response?.statusCode else { return }
            switch status {
            case 200:
                guard let object = response.value as? [String:Any] else { return }
                guard let findST = object["\(name)"] as? String else { return }
                self.presentAlert(title: "\(name) 찾기 성공", message: "\(findST)")
            case 404: self.presentAlert(title: "\(name) 찾기 실패", message: "존재하지 않는 유저")
            case 500: guard let error = response.error else { return }
            self.presentAlert(title: "에러", message: "\(error.errorDescription ?? "에러 발생")")
            default: return
            }
        }
    }
    
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}



