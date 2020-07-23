import UIKit

final class DatePickerXib: UIView {
    
    private let xibName = "DatePickerXib"
    var alarmDate: String!
    var delegate: DatePickerXibDelegate?
    private let ud = UserDefaults.standard
    
    @IBOutlet weak var alarmTextField: UITextField!
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var okBtn: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    private func commonInit(){
        let view = Bundle.main.loadNibNamed(xibName, owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    @IBAction func getOk(_ sender: UIButton) {
        delegate?.listAppend(value: alarmTextField.text!)
        delegate?.eventListAppend(value: alarmDate)
    }
    
    @IBAction func changeDatePicker(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        alarmDate = formatter.string(from: sender.date)
    }
}

protocol DatePickerXibDelegate {
    func listAppend(value: String)
    func eventListAppend(value: String)
}
