//
//  TKBViewController.swift
//  TTCN-iSocial
//
//  Created by Kai Jendo on 3/3/17.
//  Copyright © 2017 Kai Jendo. All rights reserved.
//

import UIKit
import CVCalendar

class TKBViewController: UIViewController {
    public var arrSubjectDate:[CVDate] = []
    
//MARK: IBOutlet
    @IBOutlet weak var ViewDetailsDay: UIView!
    @IBOutlet weak var lblNumberDetailsDay: UILabel!
    @IBOutlet weak var lblNameDetailsDay: UILabel!
    @IBOutlet weak var lblQuote: UILabel!
    @IBOutlet weak var lblAuth: UILabel!
    @IBOutlet weak var menuView: CVCalendarMenuView!
    @IBOutlet weak var calendarView: CVCalendarView!
    @IBOutlet weak var txtNewEvent: UITextField!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var lblMonth: UILabel!
    @IBOutlet weak var imgQuotes: UIImageView!
    @IBOutlet weak var btnCreate: UIButton!
    
//MARK: variable
    var animationFinished   = true
    
//MARK: Action
    @IBAction func abtnRate(_ sender: Any) {
    }
    @IBAction func abtnCreate(_ sender: Any) {
    }
    @IBAction func abtnNext(_ sender: Any) {
        calendarView.loadNextView()
    }
    @IBAction func abtnBack(_ sender: Any) {
        calendarView.loadPreviousView()
    }
    @IBAction func abtnToday(_ sender: Any) {
        calendarView.toggleCurrentDayView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let longGesture = UILongPressGestureRecognizer(target: self, action: Selector(("Long")))
            btnCreate.addGestureRecognizer(longGesture)
            self.getSemester()
            self.getQuote()
            self.randomImageQuotes()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
            view.addGestureRecognizer(tap)
        if let currentCalendar = currentCalendar {
            lblMonth.text = CVDate(date: Date(), calendar: currentCalendar).globalDescription
        }
    }
    override func awakeFromNib() {
        let timeZoneBias = 420
        currentCalendar = Calendar.init(identifier: .gregorian)
        if let timeZone = TimeZone.init(secondsFromGMT: -timeZoneBias * 60) {
            currentCalendar?.timeZone = timeZone
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        calendarView.commitCalendarViewUpdate()
        menuView.commitMenuViewUpdate()
        lblNumberDetailsDay.text = "\(components.day!)"
        lblNameDetailsDay.text = "\(configMyComponents())"
        calendarView.contentController.refreshPresentedMonth()
    }
}


