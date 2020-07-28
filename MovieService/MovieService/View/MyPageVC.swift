import UIKit
import Firebase

class MyPageVC: UIViewController {

    @IBOutlet weak var logOutBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func getLogOut(_ sender: Any) {
        self.presentVC(identifier: "LoginVC")
    }
}
