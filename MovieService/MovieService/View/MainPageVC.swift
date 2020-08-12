import UIKit
import RxSwift
import RxCocoa
import Alamofire

//MARK: MainPageVC
class MainPageVC: UIViewController {
    
    let disposeBag = DisposeBag()
    let apiService = APIService()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        let dateString = getDateString(format: "yyyyMMdd", date: Date())
        
//        self.apiService.loadMovie(apiRequest: ChartMovieRequest(date: ""))
//            .map{ [$0]}
//            .bind(to: tableView.rx.items(cellIdentifier: MovieCell.xibName, cellType: MovieCell.self) { index, movie, cell in
//                cell.movie = movie
//            }
//            .disposed(by: disposeBag)
//        )
        
//        self.apiService
//            .loadMovie(apiRequest: ChartMovieRequest(date: dateString)).flatMap { request -> Observable<ChartMovieRequest> in
//                return self.apiService
//                    .bind(to: tableView.rx.items(cellIdentifier: MovieCell.xibName, cellType: MovieCell.self)) { index, movie, cell in
//                        cell.movie = movie
//                }.disposed(by: disposeBag)
//                //.flatMap { request -> Observable<[SearchMovieInfo]> in
//                //                return self.apiService.get(apiRequest: request, headers: ["Content-Type" : "application/json","":""], url: url.naver)
//                return self.apiService.loadMovie(apiRequest: request, url: .naver)
//        }
        
        Observable.zip(self.tableView.rx.itemSelected, self.tableView.rx.modelSelected(List.self))
            .bind { [unowned self] indexPath, model in
                guard let vc:DetailVC = self.controller(storyBoardName: "MainPage", name: .detail) else { return }
                vc.item = model
                self.navigationController?.pushViewController(vc, animated: true)
        }.disposed(by: self.disposeBag)
        
        tableView.rowHeight = 120
    }
}

//MARK: ChartMovieRequest
class ChartMovieRequest: APIRequest {
    var path = "key=430156241533f1d058c603178cc3ca0e&"
    var parameters = [String : String]()
    
    init(date: String) {
        parameters["targetDt"] = date
    }
}
