import UIKit
import RxSwift
import RxCocoa
import Alamofire

//MARK: MainPageVC
class MainPageVC: UIViewController {
    
    let disposeBag = DisposeBag()
    let apiService: APIService = APIService()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.tableView.rowHeight = 120
        let dateString = getDateString(format: "yyyyMMdd", date: Date())
    
        let a: Observable<[MovieModel]> = apiService.loadMovie(apiRequest: ChartMovieRequest(date: dateString))
        a.bind(to: tableView.rx.items(cellIdentifier: MovieCell.xibName, cellType: MovieCell.self)) { index, model, cell in
            cell.textLabel?.text = model.boxOfficeResult.dailyBoxOfficeList[index].movieNm
        }.disposed(by: disposeBag)
        
        Observable.zip(self.tableView.rx.itemSelected, self.tableView.rx.modelSelected(List.self))
            .bind { [unowned self] indexPath, model in
                guard let vc:DetailVC = self.controller(storyBoardName: "MainPage", name: .detail) else { return }
                vc.item = model
                self.navigationController?.pushViewController(vc, animated: true)
        }.disposed(by: self.disposeBag)
    }
}

//MARK: ChartMovieRequest
struct ChartMovieRequest: APIRequest {
    var path = "key=430156241533f1d058c603178cc3ca0e&"
    var parameters = [String : String]()
    
    init(date: String) {
        parameters["targetDt="] = date
    }
}
