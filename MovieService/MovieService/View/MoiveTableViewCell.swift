import UIKit

class MoiveTableViewCell: UITableViewCell {
    
    static let xibName = "MyCell"

    @IBOutlet weak var movieOpenDate: UILabel!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var cumulativeAudience: UILabel!
    @IBOutlet weak var rank: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
