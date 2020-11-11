import UIKit

import RxSwift
import RxCocoa

final class DatePickerXib: UIView {
<<<<<<< Updated upstream
    
    var alarmList: PublishSubject<List>?
=======
    var alarmList: PublishSubject<[List]>?
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
        bindAction()
=======
//        bindAction()
>>>>>>> Stashed changes
        self.datePicker.addTarget(self, action: #selector(changeDatePicker(_:)), for: .valueChanged)
    }
    
    private func commonInit(){
        let view = Bundle.main.loadNibNamed(self.xibName, owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
    
<<<<<<< Updated upstream
=======
    @IBAction func getOK(_ sender: UIButton) {
        self.alarmList?.subscribe({ _ in
            self.alarmList?.onNext([List(date: self.datePicker.date, dateListText: self.alarmTextField.text!)])
        })
        print(self.alarmList)
    }
}

extension DatePickerXib {
>>>>>>> Stashed changes
    @objc func changeDatePicker(_ sender: UIDatePicker) {
        noti.showEduNotification(date: sender.date + 3600 * 9 - 86400)
    }
    
    func bindAction() {
        okBtn.rx.tap
            .map { (self.alarmTextField.text?.isEmpty ?? false) }
            .map { b in
                if b {
                    self.alarmList?.onNext([List(date: self.datePicker.date, dateListText: self.alarmTextField.text!)])
                }
            }
            .subscribe()
            .dispose()
    }
}

extension DatePickerXib {
    func bindAction() {
        okBtn.rx.tap
            .map { (self.alarmTextField.text?.isEmpty ?? false) }
            .map {
                if $0 {
                    self.alarmList?.onNext(List(date: self.datePicker.date, dateListText: self.alarmTextField.text!))
                }
            }.subscribe()
            .dispose()
    }
}

