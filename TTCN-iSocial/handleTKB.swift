//
//  handleTKB.swift
//  TTCN-iSocial
//
//  Created by Kai Jendo on 3/3/17.
//  Copyright © 2017 Kai Jendo. All rights reserved.
//

import Foundation
import CVCalendar

extension TKBViewController {
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func getSemester(){
        DispatchQueue.main.async {
        UserDefaults.standard.object(forKey: "saveTKBData")
        status = true
        dateFormatter.dateStyle     = .short
        dateFormatter.timeStyle     = .none
        dateFormatter.dateFormat    = "DD/MM/YYYY"
        let url = URL(string: "\(get.URL_TKB)?api=\(get.GET)&\(get.PATH)=student-time-table&access-token=\(resultFinal!)&semester=0")!
        let data = try! Data(contentsOf: url)
        let result = try? JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
        let result2 = result?["data"]  as! [String:Any]
        if let result3 = result2["current"] as? [String:Any] {
            let resultSubject = result3["subject"] as! [[String:Any]]
            for subject in resultSubject {
                _subjectID.append(subject["subjectId"] as! String)
                _subjectNews = _subjectID.orderedSetValue
                _subjectName.append(subject["subjectName"] as! String)
                _subjectTeacher = _subjectTeacher.arrayRemovingObject(object: "Dương Thị Quy")               
                _subjectNameNews = _subjectName.orderedSetValue
                _subjectTeacher.append(subject["subjectTeacher"] as! String)
                _subjectTeacherNews = _subjectTeacher.orderedSetValue
                
                _subjectTeacherNews.insert("", at: _subjectTeacherNews.count)
            }

            let result4 = result3["table"] as! [[String:Any]]
            for i in result4 {
                subjectId    .append(i["subjectId"]     as! String)
                subjectDate  .append(i["subjectDate"]   as! String)
                subjectTime  .append(i["subjectTime"]   as! String)
                subjectPlace .append(i["subjectPlace"]  as! String)
            }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/mm/yyy"
            for dates in subjectDate{
                let myDate = dateFormatter.date(from: dates)!
                arrSubject.append(myDate)
            let dateFromString = dates.components(separatedBy: "/")
            self.arrSubjectDate.append(CVDate(day: Int(dateFromString[0])!, month: Int(dateFromString[1])!, week: (Int(dateFromString[0])!/7), year: Int(dateFromString[2])!, calendar: currentCalendar!))
            }
        }
    }
    }
}
//MARK: Custom Calendar

extension TKBViewController: CVCalendarMenuViewDelegate, CVCalendarViewDelegate {
    
    func presentationMode() -> CalendarMode {
        return .monthView
    }
    
    func firstWeekday() -> Weekday {
        return .monday
    }
    
    func preliminaryView(shouldDisplayOnDayView dayView: DayView) -> Bool {
        if (dayView.isCurrentDay) {
            return true
        }
        return false
    }
    
    func preliminaryView(viewOnDayView dayView: DayView) -> UIView {
        let circleView = CVAuxiliaryView(dayView: dayView, rect: dayView.frame, shape: CVShape.circle)
        circleView.fillColor = .colorFromCode(0xCCCCCC)
        return circleView
    }
    
    private func shouldSelectDayView(dayView: DayView) -> Bool {
        return arc4random_uniform(3) == 0 ? true : false
    }
    
    func shouldAutoSelectDayOnMonthChange() -> Bool {
        return false
    }
    
    func didSelectDayView(_ dayView: CVCalendarDayView, animationDidFinish: Bool) {
        selectedDay = dayView
       DispatchQueue.main.async {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "details") as! detailsTKBViewController
        self.navigationController?.pushViewController(vc, animated: true)
        for i in 0..<self.arrSubjectDate.count {
            if Int(self.arrSubjectDate[i].day) == selectedDay.date.day && Int(self.arrSubjectDate[i].month) == selectedDay.date.month && Int(self.arrSubjectDate[i].year) == selectedDay.date.year {
                vc.subject.append(subjectId[i])
                vc.subjectDate.append(subjectId[i])
                vc.subjectTime.append(subjectTime[i])
                vc.subjectLocation.append(subjectPlace[i])
            }
        }
        }
    }
    
    func dotMarker(shouldShowOnDayView dayView: DayView) -> Bool {
        var arrMakeDot:[Date] = []
        for i in arrSubject {
            arrMakeDot.append(i)
        }
        _ = dayView.date.convertedDate(calendar: currentCalendar!)
        if arrMakeDot.contains(date) {
            return true
        }
        return false
    }
    
    func shouldSelectRange() -> Bool {
        return true
    }
        
    func presentedDateUpdated(_ date: CVDate) {
        if lblMonth.text != date.globalDescription && self.animationFinished {
            let updatedMonthLabel = UILabel()
            updatedMonthLabel.textColor = lblMonth.textColor
            updatedMonthLabel.font = lblMonth.font
            updatedMonthLabel.textAlignment = .center
            updatedMonthLabel.text = date.globalDescription
            updatedMonthLabel.sizeToFit()
            updatedMonthLabel.alpha = 0
            updatedMonthLabel.center = self.lblMonth.center
            let offset = CGFloat(48)
            updatedMonthLabel.transform = CGAffineTransform(translationX: 0, y: offset)
            updatedMonthLabel.transform = CGAffineTransform(scaleX: 1, y: 0.1)
            UIView.animate(withDuration: 0.35, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                self.animationFinished = false
                self.lblMonth.transform = CGAffineTransform(translationX: 0, y: -offset)
                self.lblMonth.transform = CGAffineTransform(scaleX: 1, y: 0.1)
                self.lblMonth.alpha = 0
                updatedMonthLabel.alpha = 1
                updatedMonthLabel.transform = CGAffineTransform.identity
            }) { _ in
                self.animationFinished = true
                self.lblMonth.frame = updatedMonthLabel.frame
                self.lblMonth.text = updatedMonthLabel.text
                self.lblMonth.transform = CGAffineTransform.identity
                self.lblMonth.alpha = 1
                updatedMonthLabel.removeFromSuperview()
            }
            
            self.view.insertSubview(updatedMonthLabel, aboveSubview: self.lblMonth)
        }
        
    }

    func selectionViewPath() -> ((CGRect) -> (UIBezierPath)) {
        return { UIBezierPath(rect: CGRect(x: 0, y: 0, width: $0.width, height: $0.height)) }
    }

    func supplementaryView(shouldDisplayOnDayView dayView: DayView) -> Bool {
        guard let currentCalendar = currentCalendar else {
            return false
        }
        var components = Manager.componentsForDate(Foundation.Date(), calendar: currentCalendar)
            if dayView.date.year == components.year &&
            dayView.date.month == components.month {
            if (dayView.date.day == 3 || dayView.date.day == 13 || dayView.date.day == 23)  {
                return true
            }
            return false
        } else {
            if (Int(arc4random_uniform(3)) == 1) {
                return true
            }
            return false
        }
    }
    
    func weekdaySymbolType() -> WeekdaySymbolType {
        return .short
    }

    func dayOfWeekTextColor() -> UIColor {
        return UIColor.black
    }
    
 
    func disableScrollingBeforeDate() -> Date {
        return Date()
    }
    
    func maxSelectableRange() -> Int {
        return 14
    }
    
    func earliestSelectableDate() -> Date {
        return Date()
    }
    
    func latestSelectableDate() -> Date {
        var dayComponents = DateComponents()
        dayComponents.day = 70
        let calendar = Calendar(identifier: .gregorian)
        if let lastDate = calendar.date(byAdding: dayComponents, to: Date()) {
            return lastDate
        } else {
            return Date()
        }
    }
}
extension TKBViewController: CVCalendarViewAppearanceDelegate {
    
    func dayLabelWeekdayDisabledColor() -> UIColor {
        return UIColor.lightGray
    }
    
    func dayLabelPresentWeekdayInitallyBold() -> Bool {
        return true
    }
    
    func spaceBetweenDayViews() -> CGFloat {
        return 2
    }
    
    func dayLabelFont(by weekDay: Weekday, status: CVStatus, present: CVPresent) -> UIFont { return UIFont.systemFont(ofSize: 14) }
    
    func dayLabelColor(by weekDay: Weekday, status: CVStatus, present: CVPresent) -> UIColor? {
        switch (weekDay, status, present) {
        case (_, .selected, _), (_, .highlighted, _): return Color.selectedText
        case (.sunday, .in, _): return Color.sundayText
        case (.sunday, _, _): return Color.sundayTextDisabled
        case (_, .in, _): return Color.text
        default: return Color.textDisabled
        }
    }
    
    func dayLabelBackgroundColor(by weekDay: Weekday, status: CVStatus, present: CVPresent) -> UIColor? {
        switch (weekDay, status, present) {
        case (.sunday, .selected, _), (.sunday, .highlighted, _): return Color.sundaySelectionBackground
        case (_, .selected, _), (_, .highlighted, _): return Color.selectionBackground
        default: return nil
        }
    }
    
    func dotMarker(colorOnDayView dayView: CVCalendarDayView) -> [UIColor] {
            return [UIColor.red]
        }

    
}
extension TKBViewController{

    func toggleMonthViewWithMonthOffset(offset: Int) {
        guard let currentCalendar = currentCalendar else {
            return
        }
        var components = Manager.componentsForDate(Foundation.Date(), calendar: currentCalendar) // from today
        components.month! += offset
        let resultDate = currentCalendar.date(from: components)!
        self.calendarView.toggleViewWithDate(resultDate)
    }
    
    func didShowNextMonthView(_ date: Date) {
        guard let currentCalendar = currentCalendar else {
            return
        }
        
        let components = Manager.componentsForDate(date, calendar: currentCalendar) // from today
        
        print("Showing Month: \(components.month!)")
    }
  
    func didShowPreviousMonthView(_ date: Date) {
        guard let currentCalendar = currentCalendar else {
            return
        }
        let components = Manager.componentsForDate(date, calendar: currentCalendar) // from today
        print("Showing Month: \(components.month!)")
    }
    
    func configMyComponents()-> String {
        let myComponents = Calendar.current.component(.weekday, from: Date())
        let myweekDay = myComponents
        switch myweekDay {
        case 1:
            lblNumberDetailsDay.textColor = Color.sundayText
            lblNameDetailsDay.textColor = Color.sundayText
            return "CHỦ NHẬT"
        case 2:
            return "THỨ HAI"
        case 3:
            return "THỨ BA"
        case 4:
            return "THỨ TƯ"
        case 5:
            return "THỨ NĂM"
        case 6:
            return "THỨ SÁU"
        default:
            return "THỨ BẢY"
        }
    }
    
    func randomImageQuotes() {
            imgQuotes.image = UIImage(named: "bg_quote_\(arc4random_uniform(12) + 1)")
    }

    func getQuote(){
        let url = Bundle.main.url(forResource: "quote", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
        let result = json["current"] as! [[String:Any]]
        for i in result {
            arrQuote.append(i["quotes"] as! String)
            arrAuth.append( i["auth"]   as! String)
        }
        var count = arc4random_uniform(UInt32(arrQuote.count))
        if count == 0 {
            count += 1
        }
        lblQuote.text = arrQuote[Int(count)]
        lblAuth .text = arrAuth [Int(count)]
    }

}

//class Searchable {
//    var place = Place()
//    var user = User()
//}



