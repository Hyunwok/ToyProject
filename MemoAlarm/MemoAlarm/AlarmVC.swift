import UIKit
import FSCalendar
import RxSwift
import RxCocoa

//MARK: AlarmVC

class AlarmVC: UIViewController, FSCalendarDelegate, FSCalendarDataSource {

    var list = [String]()

    @IBOutlet weak var datePickerView: DatePickerXib!
    @IBOutlet weak var alarmPlusBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var showWhenTouchPlus: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarView.appearance.titleWeekendColor = .red
        calendarView.appearance.headerMinimumDissolvedAlpha = 0.0;
        tableView.delegate = self
        tableView.dataSource = self
        self.xibAndBtnIsHidden(value: true)
    }
    
    @IBAction func piusAlarm(_ sender: UIButton) {
        self.xibAndBtnIsHidden(value: false)
    }
    @IBAction func disMissXib(_ sender: UIButton) {
        self.xibAndBtnIsHidden(value: true)
    }
}


//MARK: extension

extension AlarmVC: UITableViewDelegate, UITableViewDataSource {
    func xibAndBtnIsHidden(value: Bool) {
        showWhenTouchPlus.isHidden = value
        datePickerView.isHidden = value
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // DatePickerXib
        return UITableViewCell()
    }
}
