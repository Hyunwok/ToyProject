import UIKit
import RxSwift
import RxCocoa

class MainPageVC: UIViewController {
    
    let viewModel = MovieViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    //키 : key=c16f104dccf7480daa4204c8f921d8b6
    //예시 : http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=c16f104dccf7480daa4204c8f921d8b6..&targetDt=20200720
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadView()
    }
}

