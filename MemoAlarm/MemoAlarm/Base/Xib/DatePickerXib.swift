import UIKit

final class DatePickerXib: UIView {
    
    private let xibName = "DatePickerXib"
    var alarmDate: String!
    var delegate: DatePickerXibDelegate?
    let noti = UNNotiManager()
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
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
        self.datePicker.addTarget(self, action: #selector(changeDatePicker(_:)), for: .valueChanged)
    }
    
    private func commonInit(){
        let view = Bundle.main.loadNibNamed(xibName, owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    @IBAction func getOk(_ sender: UIButton) {
        delegate?.listAppend(value: List.init(dateList:alarmDate, dateListText: alarmTextField.text!), boolean: true)
    }
    
    @objc func changeDatePicker(_ sender: UIDatePicker) {
        self.alarmDate = self.dateFormatter.string(from: sender.date)
        let koreaBeforeDate = self.dateFormatter.date(from: alarmDate!)
        noti.showEduNotification(date: koreaBeforeDate! + 3600 * 9 - 86400) // 한국 시간으로 변경하기
    }
}

protocol DatePickerXibDelegate {
    func listAppend(value: List, boolean: Bool)
}
