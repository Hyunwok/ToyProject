import UIKit
import RxSwift
import RxCocoa
import Alamofire

class MainPageVC: UIViewController {
    
    let viewModel = MovieViewModel()
    let movieArray = [MovieInfoIn]()
    var movieName: String!
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadView(url: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieList.json?key=430156241533f1d058c603178cc3ca0e")
        AF.request("http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieList.json?key=430156241533f1d058c603178cc3ca0e", method: .get).responseJSON { response in
            switch response.response?.statusCode {
            case 200: guard let value = response.value as? [String:Any] else { return }
            let searchRes = value["movieListResult"] as? [String:Any]
            guard let movieInfo = searchRes?["movieList"] as? [String:Any] else { return }
            guard let movieName = movieInfo["movieNm"] as? String else { return }
            guard let movieRank = movieInfo["rank"] as? String else { return }
            guard let openDate = movieInfo["openDt"] as? String else { return }
            guard let audi = movieInfo["audiAcc"] as? String else { return }
            MovieInfoIn.init(rank: movieRank, movieNm: movieName, openDt: openDate, audiAcc: audi)
            case 404: return
            default: return
            }
        }
        
        let observable: Observable<[MovieInfoIn]> = Observable.just(movieArray)
        observable.bind(to: tableView.rx.items(cellIdentifier: "MyCell")) { _, movie, cell in
            if let cellToUse = cell as? MovieTableCell {
             //   cellToUse.movieName.text = MovieInfo().ran
            }
        }.disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadView(url: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieList.json?key=430156241533f1d058c603178cc3ca0e")
    }
}



