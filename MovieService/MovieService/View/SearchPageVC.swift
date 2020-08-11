import UIKit
import RxSwift

class SearchPageVC: UIViewController {
    
    private let baseUrl = ""
    
    let apiService = ApiService()
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.rx.text.orEmpty
            .asObservable()
            .map { $0.lowercased() }
            .map { SearchMovieRequest(query: $0) }
            .flatMap { request -> Observable<[SearchMovieInfo]> in
//                return self.apiService.get(apiRequest: request, headers: ["Content-Type" : "application/json","":""], url: url.naver)
                return self.apiService.get(apiRequest: request, url: .naver)
        }
        .bind(to: tableView.rx.items(cellIdentifier: "searchCell")) { index, model, cell in
            cell.textLabel?.text = model.title
        }
        .disposed(by: disposeBag)
    }
}
