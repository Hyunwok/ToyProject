import UIKit
import RxSwift

final class DatePickerXib: UIView {
    
    var alarmDate: String!
    var delegate: DatePickerXibDelegate?
    private let noti = UNNotiManager()
    private let xibName = "DatePickerXib"
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy-MM-dd"
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
        if alarmTextField.text!.isEmpty {
            delegate?.listAppend(value: List.init(dateList:"", dateListText: ""), boolean: false)
            return
        } else {
            delegate?.listAppend(value: List.init(dateList:alarmDate, dateListText: alarmTextField.text!), boolean: true)
        }
    }
    
    @objc func changeDatePicker(_ sender: UIDatePicker) {
        var list = [Date]()
        self.alarmDate = self.dateFormatter.string(from: sender.date)
        let koreaBeforeDate = self.dateFormatter.date(from: alarmDate)
        noti.showEduNotification(date: koreaBeforeDate! + 3600 * 9 - 86400)
        list.append(koreaBeforeDate!)
        UserDefaults.standard.set(list, forKey: "dayList")
    }
}

protocol DatePickerXibDelegate {
    func listAppend(value: List, boolean: Bool)
}
