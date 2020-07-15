import UIKit

final class DatePickerXib: UIView {
    
    private let xibName = "DatePickerXib"
    var alarmDate: String!
    var delegate: DatePickerXibDelegate?
    
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
        delegate?.listAppend(value: alarmTextField.text!)
        delegate?.eventListAppend(value: alarmDate)
    }
    
    @objc func getTime() {
        let notiDate = UNNotiManager()
        notiDate.showEduNotification(date: datePicker.date)
        var formatter = DateFormatter().dateFormat
        formatter = "yyyy-MM-dd"
        alarmDate = DateFormatter().string(from: datePicker.date)
    }
}

protocol DatePickerXibDelegate {
    func listAppend(value: String)
    func eventListAppend(value: String)
}
