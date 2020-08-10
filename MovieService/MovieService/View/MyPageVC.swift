import UIKit
import Firebase

class MyPageVC: UIViewController {

    @IBOutlet weak var logOutBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func getLogOut(_ sender: Any) {
        guard let vc: LoginVC = self.controller(storyBoardName: "Main", name: .login) else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
