import Foundation

// MARK: UIViewController
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
    
    func pushVC(identifier: String) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: identifier) else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

