import UIKit

class AlarmCell: UITableViewCell {
    
    static let identifier = "AlarmCell"
    
    @IBOutlet weak var alarmText: UILabel!
    @IBOutlet weak var alarmDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
