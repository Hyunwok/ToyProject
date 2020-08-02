import UIKit
import RxSwift
import RxCocoa
import Alamofire

class MainPageVC: UIViewController {
    
    private let key = "430156241533f1d058c603178cc3ca0e"
    let viewModel = MovieReloadViewModel()
    let disposeBag = DisposeBag()
    let apiService = APIService()
    let test = BehaviorSubject<[String]>(value: ["1","2","3"])
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        print(self.viewModel.loadView(url: ""))
        let result : Observable<Result> = self.viewModel.loadView(url: "").asObservable()
        result.bind(to: tableView.rx.items(cellIdentifier: "MyCell")) { index, _, cell in
            if let cellToUse = cell as? MovieTableCell {
                emitter.boxOfficeResult.dailyBoxOfficeList[index].movieNm
            }
        }
    }
}



