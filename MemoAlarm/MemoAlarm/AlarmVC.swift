import UIKit
import FSCalendar
import UserNotifications
import RxCocoa
import RxSwift

//MARK: AlarmVC

class AlarmVC: UIViewController, UNUserNotificationCenterDelegate {
    
    var calendarDataSource: [String:String] = ["2020-08-07":"잉기모띠"]
    let commentString = BehaviorRelay<[String]>(value: [])
    let userNoti = UNNotiManager()
    var listDate: String!
    var listText = [String]()
    var list = [String]()
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    @IBOutlet weak var datePickerXib: DatePickerXib!
    @IBOutlet weak var alarmPlusBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var subjectXib: SubjectXib!
    @IBOutlet weak var showWhenTouchPlus: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setDelegate()
        self.xibAndBtnIsHidden(value: true)
        self.aboutCalendar()
        self.reloadUserDefault()
        self.subjectXib.isHidden = true
        tableView.register(AlarmCell.self, forCellReuseIdentifier: AlarmCell.identifier)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisa(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        commentString.bind(to: tableView.rx.items(cellIdentifier: "")) { index, comment, cell in
            if let newCell = cell as? AlarmCell {
                newCell.alarmText.text = comment
            }
        }
    }
    
    @IBAction func changeXib(_ sender: UIButton) {
        if sender.isSelected {
            hideXib(value: true)
        } else {
            hideXib(value: false)
        }
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func presentXib(_ sender: UIButton) {
        self.xibAndBtnIsHidden(value: false)
        calendarView.reloadData()
    }
    
    @IBAction func disMissXib(_ sender: UIButton) {
        self.xibAndBtnIsHidden(value: true)
        calendarView.reloadData()
        reloadUserDefault()
    }
    
    func reloadUserDefault() {
        let date = Date()
        var strings = UserDefaults.standard.object(forKey: "dayList") as? [Date]
        if strings == nil { return }
        for i in 0..<strings!.count {
            if strings?.count == 0 || strings?.count == nil || strings![i] == nil{
                return
            } else if date > strings![i] {
                strings!.remove(at: i)
            }
        }
        UserDefaults.standard.set(strings, forKey: "dayList")
    }
}


//MARK: extension

extension AlarmVC: DatePickerXibDelegate  {
    func listAppend(value: List, boolean: Bool) {
        listDate = value.dateList
        list.append(listDate!)
        self.listText.append("\(value.dateListText)")
        
        tableView.reloadData()
        calendarView.reloadData()
        reloadUserDefault()
        if boolean {
            xibAndBtnIsHidden(value: boolean)
            return
        } else {
            self.showToast(text: "텍스트가 비었습니다")
        }
    }
    
    func hideXib(value: Bool) {
        calendarView.isHidden = !value
        subjectXib.isHidden = value
    }
    
    func setDelegate() {
        UNUserNotificationCenter.current().delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        calendarView.delegate = self
        datePickerXib.delegate = self
        calendarView.dataSource = self
    }
    
    func xibAndBtnIsHidden(value: Bool) {
        showWhenTouchPlus.isHidden = value
        datePickerXib.isHidden = value
    }
    
    func showToast(text: String) {
        let toastLabel = UILabel(frame: CGRect(x: view.frame.size.width/2 - 150, y: view.frame.size.height - 500, width: 300,  height : 35))
        toastLabel.backgroundColor = UIColor.black
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        view.addSubview(toastLabel)
        toastLabel.text = text
        toastLabel.font = UIFont.boldSystemFont(ofSize: 18)
        toastLabel.alpha = 0.8
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        
        UIView.animate(withDuration: 1.0, animations: {
            toastLabel.alpha = 0.0
        }, completion: {
            (isBool) -> Void in
            self.dismiss(animated: true, completion: nil)
        })
    }
}

extension AlarmVC: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let dateString = self.dateFormatter.string(from: date)
        if self.list.contains(dateString) {
            return 1
        }
        return 0
    }
    
    func aboutCalendar() {
        let ca = calendarView.appearance
        ca.headerMinimumDissolvedAlpha = 0.0;
        ca.eventOffset = CGPoint(x: 15, y: -35)
        ca.caseOptions = [.headerUsesUpperCase, .weekdayUsesSingleUpperCase]
        ca.headerDateFormat = "yyyy년 M월"
        ca.headerTitleColor = .black
        ca.weekdayTextColor =  .black
    }
    
    func calendar(_ calendar: FSCalendar, didselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let date = dateFormatter.string(from: date)
        if let comment = calendarDataSource[date] {
            commentString.accept(comment)
        }
    }
}

extension AlarmVC: UITextFieldDelegate {
    @objc func keyboardWillShow(_ sender: Notification) {
        self.view.frame.origin.y = -150
    }
    
    @objc func keyboardWillDisa(_ sender: Notification) {
        self.view.frame.origin.y = 0
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
}
