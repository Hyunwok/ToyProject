import UIKit

import RxSwift

final class DatePickerXib: UIView {
    
    static var alarmList: [List]?
    private let noti = UNNotiManager()
    private let xibName = "DatePickerXib"
    
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
        let view = Bundle.main.loadNibNamed(self.xibName, owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    @IBAction func getOk(_ sender: UIButton) {
        if !(alarmTextField.text?.isEmpty ?? false) {
            DatePickerXib.alarmList?.append(List(date: datePicker.date, dateListText: alarmTextField.text ?? ""))
        }
    }
    
    @objc func changeDatePicker(_ sender: UIDatePicker) {
        noti.showEduNotification(date: sender.date + 3600 * 9 - 86400)
    }
}
