import UIKit
import FSCalendar
import RxSwift
import RxCocoa

//MARK: AlarmVC

class AlarmVC: UIViewController, FSCalendarDelegate, FSCalendarDataSource {

    static var list = [String]()
    static var eventList = [String]()
    var today: Int!
    
    @IBOutlet weak var datePickerXib: DatePickerXib!
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
        reloadCalender()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        today = Int(formatter.string(from: Date()))
    }
    
    @IBAction func piusAlarm(_ sender: UIButton) {
        self.xibAndBtnIsHidden(value: false)
        
    }
    @IBAction func disMissXib(_ sender: UIButton) {
        self.xibAndBtnIsHidden(value: true)
        reloadCalender()
        print(AlarmVC.eventList)
    }
    
}


//MARK: extension

extension AlarmVC: UITableViewDelegate, UITableViewDataSource {
    func xibAndBtnIsHidden(value: Bool) {
        showWhenTouchPlus.isHidden = value
        datePickerXib.isHidden = value
    }
    
    func reloadCalender() {
        var date = [String]()
        for i in AlarmVC.eventList { if today > Int(i)! { date.append(i) } }
        print(date)
        func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
            
            return 0
        }
//        calendarView.appearance
//        datePickerXib.alarmDate
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AlarmVC.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlarmCell", for: indexPath) as! AlarmCell
        cell.alarmLbl.text = datePickerXib.alarmText
        return cell
    }
}
