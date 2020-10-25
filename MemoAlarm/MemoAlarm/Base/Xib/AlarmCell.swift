import UIKit

class AlarmCell: UITableViewCell {
    
    static let identifier = "AlarmCell"
    
    @IBOutlet weak var alarmText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
