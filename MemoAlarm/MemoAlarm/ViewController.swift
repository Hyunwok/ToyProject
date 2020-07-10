import UIKit
import FSCalendar
import RxSwift
import RxCocoa

class ViewController: UIViewController,FSCalendarDelegate, FSCalendarDataSource {
    
    var list = [String]()

    @IBOutlet weak var alarmPlusBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var calendarView: FSCalendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarView.appearance.titleWeekendColor = .red
        calendarView.appearance.headerMinimumDissolvedAlpha = 0.0;
        tableView.delegate = self
        tableView.dataSource = self
    }
    @IBAction func piusAlarm(_ sender: UIButton) {
        
    }
    

}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
        return cell
    }
    
    

}
