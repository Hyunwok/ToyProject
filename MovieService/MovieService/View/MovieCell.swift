import UIKit

class MovieCell: UITableViewCell {
    
    static let xibName = "MyCell"
    
    // MARK: - Properties
    var movie:List? {
        didSet {
            guard let movie: List = movie else { return }
            self.movieName.text = movie.movieNm
            self.movieOpenDate.text = movie.openDt
            self.cumulativeAudience.text = movie.audiAcc
            self.rank.text = movie.rank
        }
    }

    @IBOutlet weak var cumulativeAudience: UILabel!
    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var movieOpenDate: UILabel!
    @IBOutlet weak var movieName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
