//
//  UICalenderWeekViewCell.swift
//  Calendar_Demo
//
//  Created by Mohsin on 06/11/2024.
//

import UIKit
import JTAppleCalendar
import SwiftDate

protocol UICalenderWeekViewCellProtocol where Self: UITableViewCell {
    func config(isMonthMode: Bool, selectedDateIpad:Date)
    
}
protocol DateSelectedProtocol {
    func didSelectDate(date:Date)
}

class UICalenderWeekViewCell: UITableViewCell, UICalenderWeekViewCellProtocol {

    //MARK: - IBOutlet -
    
    @IBOutlet weak var calendarView: JTACMonthView!
    @IBOutlet weak var lblMonthYear: UILabel!
    @IBOutlet weak var btnForSelectMonth: UIButton!
    @IBOutlet var arrayCurrentMonthWeekLabels: [UILabel]!
    
    //MARK: - Variables -
    
    static var identifier: String { return String(describing: self) }
    static var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    var isMonth: Bool = true
    var selectedDate: Date? = nil
    var delegate:DateSelectedProtocol? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func config(isMonthMode: Bool, selectedDate:Date, delegate controller:DateSelectedProtocol? = nil) {
        self.isMonth = isMonthMode
        delegate = controller
        calendarView.reloadData()
        calendarView.scrollToDate(selectedDate, animateScroll: false)
    }
    
    func config(isMonthMode: Bool, selectedDateIpad:Date) {
        self.isMonth = isMonthMode
        calendarView.reloadData()
        calendarView.scrollToDate(selectedDateIpad, animateScroll: false)
    }

    func didChangeMonth() {
        guard let date = calendarView.visibleDates().monthDates.first?.date else { return }
        
        setupCalendarLabel(date: date)
    }
    
    func setupCalendarLabel(date: Date) {
        var monthDate:Date = date
        
        if !isMonth && date.in(region: .local).weekOfYear == selectedDate?.in(region: .local).weekOfYear {
            monthDate = selectedDate ?? monthDate
        }
        let month = monthDate.in(region: .local).toFormat("MMMM")
        let year = monthDate.in(region: .local).toFormat("yyyy")
        
        if UIDevice.isIpad {
            lblMonthYear.text = month + " " + year
        } else {
            let attributeText = NSMutableAttributedString(string: month, attributes: [.foregroundColor: UIColor.appColor(.c180738TOFFFFFF), .font: UIFont.Gilroy.Bold(of: 16)])
            attributeText.append(NSAttributedString(string: " " + year, attributes: [.foregroundColor: UIColor.appColor(.c180738TOFFFFFF), .font: UIFont.Gilroy.Medium(of: 13)]))
            lblMonthYear.attributedText = attributeText
        }
        
    }
    
    func handleConfiguration(cell: JTACDayCell?, cellState: CellState) {
        guard let cell = cell as? CalenderCell else { return }
        
        handleCellColor(cell: cell, cellState: cellState)
        handleCellSelection(cell: cell, cellState: cellState)
    }
    
    func handleCellColor(cell: CalenderCell, cellState: CellState) {
        cell.borderWidth = 0
        cell.dayLabel.textColor = UIColor(hex: 0x180738)

        let isCurrentMonth = cellState.dateBelongsTo == .thisMonth
        cell.dayLabel.alpha = isCurrentMonth ? 1 : 0.3
        cell.selectedView.alpha = cell.dayLabel.alpha
        cell.ViewForBottomIndicator.alpha = cell.dayLabel.alpha
        cell.customCollectionView.alpha = cell.dayLabel.alpha
    }
    
    func handleCellSelection(cell: CalenderCell, cellState: CellState) {
        
        cell.selectedView.isHidden = false
        cell.selectedView.setCornerRadius(cornerRadius: UIDevice.isIpad ? 10 : 5)
        cell.selectedView.setBorder(color: AppMainColor, borderWidth: 0)
        cell.constrainForCollectionWidth.constant = 0
        
        if let fromDate = selectedDate, fromDate == cellState.date {
            cell.selectedView.backgroundColor = AppMainColor
            cell.dayLabel.textColor = .white
        } else {
            cell.selectedView.backgroundColor = UIColor.appColor(.EDEBEETO251A3A)
            cell.dayLabel.textColor = UIColor.appColor(.c180738TOFFFFFF)
        }

        if cellState.date.in(region: .local).isToday {
            if let selected = selectedDate, selected.in(region: .local).isToday {
                cell.selectedView.backgroundColor = AppMainColor
                cell.dayLabel.textColor = UIColor(hex: 0xFFFFFF)
                cell.selectedView.borderWidth = 0
            } else if selectedDate == nil {
                cell.selectedView.backgroundColor = AppMainColor
                cell.dayLabel.textColor = UIColor(hex: 0xFFFFFF)
                cell.selectedView.borderWidth = 0
            } else {
                cell.selectedView.backgroundColor = UIColor.appColor(.EDEBEETO251A3A)
                cell.dayLabel.textColor = UIColor.appColor(.c180738TOFFFFFF)
                cell.selectedView.borderWidth = 2
            }
        }
      
        var arrayColors:[UIColor] = []
        
        if cellState.date.in(region: .local).isToday {
            arrayColors = [UIColor.orange, UIColor.yellow]
        }
        
        cell.config(arrayColor: arrayColors)
        cell.ViewForBottomIndicator.backgroundColor = UIColor.appColor(.c180738TOFFFFFF)
    }
    
    //MARK: - IBAction -
    
    @IBAction func onClickLeft() {
        self.calendarView.scrollToSegment(.previous) { [weak self] in
            guard let self else { return }
            
            didChangeMonth()
        }
    }
    
    @IBAction func onClickRight() {
        self.calendarView.scrollToSegment(.next) { [weak self] in
            guard let self else { return }
            
            didChangeMonth()
        }
    }
    
}

extension UICalenderWeekViewCell: JTACMonthViewDataSource {
    
    func configureCalendar(_ calendar: JTACMonthView) -> ConfigurationParameters {
        
        let startDate = Date().dateAtStartOf(.year)
        let endDate = Date().dateAtEndOf(.year) + 1.years
        
        let parameter = ConfigurationParameters(startDate: startDate,
                                                endDate: endDate,
                                                numberOfRows: isMonth ? 6 : 1,
                                                generateInDates: .forAllMonths,
                                                generateOutDates: isMonth ? .tillEndOfGrid : .tillEndOfRow,
                                                firstDayOfWeek: .monday)
        return parameter
    }
}

extension UICalenderWeekViewCell: JTACMonthViewDelegate {
    func calendar(_ calendar: JTACMonthView, shouldSelectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) -> Bool {
        calendarView.deselectAllDates()
        return true
    }
    
    func calendar(_ calendar: JTACMonthView, shouldDeselectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) -> Bool {
        return true
    }

    func calendar(_ calendar: JTACMonthView, didSelectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        selectedDate = date
        calendarView.reloadData()
        delegate?.didSelectDate(date: date.in(region: .local).toFormat("yyyy/MM/dd").toDate("yyyy/MM/dd")?.date ?? date)
    }
    
    func calendar(_ calendar: JTACMonthView, didDeselectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        handleConfiguration(cell: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTACMonthView, didHighlightDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
    }
    
    func calendar(_ calendar: JTACMonthView, didUnhighlightDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
    }

    func calendar(_ calendar: JTACMonthView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        guard let date = visibleDates.monthDates.first?.date else { return }
        
        didChangeMonth()
    }

    func calendar(_ calendar: JTACMonthView, willScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        guard let date = visibleDates.monthDates.first?.date else { return }

        setupCalendarLabel(date: date)
    }
    
    func calendar(_ calendar: JTACMonthView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTACDayCell {
        let cell:CalenderCell = calendar.cell(for: indexPath)
        cell.dayLabel.text = cellState.text
        self.calendar(calendar, willDisplay: cell, forItemAt: date, cellState: cellState, indexPath: indexPath)
        return cell
    }
    
//    func calendar(_ calendar: JTACMonthView, headerViewForDateRange range: (start: Date, end: Date), at indexPath: IndexPath) -> JTACMonthReusableView {
//    }
    
    func scrollDidEndDecelerating(for calendar: JTACMonthView) {
    }
    
    func calendarDidScroll(_ calendar: JTACMonthView) {
        
    }
    
    func calendarSizeForMonths(_ calendar: JTACMonthView?) -> MonthSize? {
        return nil
    }
    
    func calendar(_ calendar: JTACMonthView, willDisplay cell: JTACDayCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        let daysInARow:CGFloat = 7
        handleConfiguration(cell: cell, cellState: cellState)
        
        if calendarView.cellSize != self.calendarView.frame.size.width / daysInARow {
            self.calendarView.cellSize = self.calendarView.frame.size.width / daysInARow
            calendarView.minimumLineSpacing = 16
            calendarView.reloadData()
        }
    }
    
    
    func sizeOfDecorationView(indexPath: IndexPath) -> CGRect {
        return .zero
    }
}
