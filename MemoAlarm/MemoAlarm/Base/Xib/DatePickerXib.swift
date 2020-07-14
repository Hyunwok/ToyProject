import UIKit

final class DatePickerXib: UIView {
    
    var list = [String]()
    static var eventList = [String]()
    private let xibName = "DatePickerXib"
    var alarmDate: String!
    var alarmText: String!
    
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
        self.datePicker.addTarget(self, action: #selector(getTime), for: .valueChanged)
    }
    
    private func commonInit(){
        let view = Bundle.main.loadNibNamed(xibName, owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    @IBAction func getOk(_ sender: UIButton) {
        self.alarmText = alarmTextField.text
        self.list.append(alarmText)
       
        if let date = alarmDate {
            DatePickerXib.eventList.append(date)
        }
    }
    
    @objc func getTime() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.string(from: datePicker.date)
        alarmDate = date
    }
}
