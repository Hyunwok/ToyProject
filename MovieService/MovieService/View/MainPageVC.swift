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
        
        test.bind(to: self.tableView.rx.items(cellIdentifier: "MyCell")) { (row, elem, cell) in
            print("abc")
        }.disposed(by: self.disposeBag)
        
        viewModel.loadView(url: "").bind(to: self.tableView.rx.items(cellIdentifier: "cell")) { (row, elem, cell) in
            print("abc")
        }.disposed(by: self.disposeBag)
        
        viewModel.loadView(url: "").bind(onNext: { emitter in
            tableView.rx.items(cellIdentifier: "MyCell") { index, _, cell in
                if let cellToUse = cell as? MovieTableCell {
                    emitter.boxOfficeResult.dailyBoxOfficeList[index].movieNm
                }
            }
        })
    }
}



