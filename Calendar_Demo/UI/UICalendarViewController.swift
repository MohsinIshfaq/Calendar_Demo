//
//  UICalendarViewController.swift
//  Calendar_Demo
//
//  Created by Mohsin on 06/11/2024.
//

import UIKit
import Stevia

extension UIDevice {
    static var isIphone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    
    static var isIpad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
}

class UICalendarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, monthNumberDelegate, DateSelectedProtocol {
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var calendarTableView: UITableView!
    
    //MARK: - Variables
    
    private var monthViewController = UIMonthSubViewController()
    private var isMonthViewMode : Bool = false
    private var selectedDate:Date = Date() {
        didSet {
            calendarTableView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.calendarTableView.reloadData()
    }
    
    // MARK: - TableView -
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        guard indexPath.row == 0 else { return UITableView.automaticDimension }
        if UIDevice.isIpad {
            return isMonthViewMode ? 810 : 230
        } else {
            return isMonthViewMode ? 386 : 160
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell:UICalenderWeekViewCell = tableView.cell(for: indexPath)
            cell.config(isMonthMode: isMonthViewMode, selectedDate: selectedDate, delegate: self)
            cell.btnForSelectMonth.addTarget(self, action: #selector(onClickForSelectMonth), for: .touchUpInside)
            return cell
        } else {
            let cell: UIHeaderOfDayViewCell = tableView.cell(for: indexPath)
            cell.config(isExpanded: isMonthViewMode)
            cell.btnArrow.addTarget(self, action: #selector(onClickMonthOrWeek(_:)), for: .touchUpInside)
            
            return cell
        }
    }
    
    //MARK: - monthNumberDelegate -
    
    func selectedMonth(month: Int) {
        if let newDate = selectedDate.dateBySet([.month : month]) {
            selectedDate = newDate
        }
    }
    
    //MARK: - DateSelectedProtocol -
    
    func didSelectDate(date: Date) {
        selectedDate = date
    }
    
    // MARK: - @IBAction -
    
    @IBAction func onClickForSelectMonth(_ sender: UIButton, cell: UICalenderWeekViewCell) {
        if monthViewController.view.tag == 0 {
            monthViewController = UIMonthSubViewController()
            monthViewController.view.tag = 1
            monthViewController.delegate = self
            AppDelegate.delegate.calendarController.view.addSubview(monthViewController)
            monthViewController.view.translatesAutoresizingMaskIntoConstraints = false
            monthViewController.view.fillContainer()
            monthViewController.viewForMonths.Top == calendarTableView.Top + 5
        }
        
        monthViewController.indexOfMonth = selectedDate.month - 1
    }
    
    @IBAction func onClickMonthOrWeek(_ sender: UIButton) {
        isMonthViewMode = !isMonthViewMode
        animate(duration: 0.3) {
            self.calendarTableView.beginUpdates()
            if let tmpCell = self.calendarTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? UICalenderWeekViewCellProtocol {
                tmpCell.config(isMonthMode: self.isMonthViewMode, selectedDateIpad: self.selectedDate)
            }
            if let tmpCell = self.calendarTableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? UIHeaderOfDayViewCell {
                tmpCell.config(isExpanded: self.isMonthViewMode)
            }
            self.calendarTableView.endUpdates()
        }
    }
    
}
