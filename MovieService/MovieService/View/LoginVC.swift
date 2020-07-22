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
        AF.request("http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieList.json?key=430156241533f1d058c603178cc3ca0e", method: .get).responseJSON { response in
            switch response.response?.statusCode {
            case 200: guard let value = response.value as? [String:Any] else { return }
                let searchRes = value["movieListResult"] as? [String:Any]
            guard let movieInfo = searchRes?["movieList"] as? [String:Any] else { return }
            guard let movieName = movieInfo["movieNm"] as? String else { return }
                print(movieName)
                
            default: return
            }
        }
    }
    
    
    @IBAction func getLogin(_ sender: UIButton) {
        //  viewModel.
    }
    
    @IBAction func getRegister(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterVC") else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

