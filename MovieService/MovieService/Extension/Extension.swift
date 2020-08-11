import UIKit

enum StorybardName: String {
    case detail = "DetailVC"
    case main = "MainPageVC"
    case login = "LoginVC"
    case register = "RegisterVC"
    case tabbar = "TabBarVC"
}

extension UIViewController {

    func controller<T>(modal:Bool = false, storyBoardName: String, name: StorybardName) -> T? {
        let storyboard = UIStoryboard.init(name: storyBoardName, bundle: Bundle.main)
        guard let vc:T = storyboard.instantiateViewController(identifier: name.rawValue) as? T else { return nil }
        return vc
    }
    
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        self.view.frame.origin.y = -150
    }
    
    @objc func keyboardWillDisa(_ sender: Notification) {
        self.view.frame.origin.y = 0
    }
}
