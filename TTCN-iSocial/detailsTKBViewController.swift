//
//  detailsTKBViewController.swift
//  TTCN-iSocial
//
//  Created by Kai Jendo on 3/25/17.
//  Copyright © 2017 Kai Jendo. All rights reserved.
//

import UIKit
import CVCalendar

class detailsTKBViewController: UIViewController {
//variable
    var city = "Thái Nguyên"
    var subjectName     :    [String] = []
    var subjectDate     :    [String] = []
    var subjectTime     :    [String] = []
    var subjectLocation :    [String] = []
    var subjectTeacher  :    [String] = []
    var arrNote         :    [String] = []
    var subject         :    [String] = []
    var subjectID       :    [String] = []
    var arrDate         :    [CVDate] = []
    
    let swipeRightOrange = UISwipeGestureRecognizer(target: self, action:#selector(swipeRight(_:)))
    var selectDayPre = selectedDay.date.day
    let swipeLeftOrange:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft(_:)))
    
    
    @IBOutlet weak var tblDetails: UITableView!
    @IBOutlet weak var imgStatus: UIImageView!
    @IBOutlet weak var lblCesius: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var imgLocation: UILabel!
    @IBOutlet weak var lblHightTemp: UILabel!
    @IBOutlet weak var lblLowTemp: UILabel!
//    @IBOutlet weak var lblHumidity: UILabel!
//    @IBOutlet weak var lblWind: UILabel!
    @IBOutlet weak var lblNotification: UILabel!
    
    
    @IBAction func swipeLeft(_ sender: Any) {
        swipeRightOrange.direction = UISwipeGestureRecognizerDirection.left
        for i in arrSubjectDate {
            arrDate.append(i)
        }
        let nextDay = components.day! + 1
        for i in arrDate {
            if i.day == nextDay {
                
             let vc = self.storyboard?.instantiateViewController(withIdentifier: "details") as! detailsTKBViewController
            self.navigationController?.pushViewController(vc, animated: false)
            }
        }
        tblDetails.reloadData()
    }
    
    @IBAction func swipeRight(_ sender: Any) {
        swipeLeftOrange.direction = UISwipeGestureRecognizerDirection.right
        print("right")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleSubject()
        displayCurrentWeather()
        lblNotification.text = "Hôm nay không có sự kiện"
        tblDetails.register(UINib(nibName: "customDetailsTKBTableViewCell", bundle: nil), forCellReuseIdentifier: "detailsView")
        
        tblDetails.register(UINib(nibName: "customNoteTableViewCell", bundle: nil), forCellReuseIdentifier: "customNote")
        
        tblDetails.dataSource = self
        tblDetails.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
