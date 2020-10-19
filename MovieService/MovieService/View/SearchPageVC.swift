import UIKit
import RxSwift


//MARK: SearchPageVC
class SearchPageVC: UIViewController {
    
    let apiService = APIService()
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.searchBar.rx.text.orEmpty
//            .asObservable()
//            .map { $0.lowercased() }
//            .map { SearchMovieRequest(query: $0) }
//            .flatMap { request -> Observable<[SearchModel]> in
//                return self.apiService.loadMovie(apiRequest: request, url: .naver)
//        }
//        .bind(to: tableView.rx.items(cellIdentifier: "searchCell")) { index, model, cell in
//            cell.textLabel?.text = model.title
//        }
//        .disposed(by: disposeBag)
    }
}


// MARK: SearchMovieRequest
struct SearchMovieRequest: APIRequest {
    var parameters = [String : String]()
    var path = ""
    
    init(query: String) {
        parameters["query"] = query
    }
}
