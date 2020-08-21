import UIKit

class AlarmCell: UITableViewCell {
    
    @IBOutlet weak var alarmText: UILabel!
    static let identifier = "AlarmCell"
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
