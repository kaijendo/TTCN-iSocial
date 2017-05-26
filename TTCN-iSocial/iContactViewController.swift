//
//  iContactViewController.swift
//  TTCN-iSocial
//
//  Created by Kai Jendo on 3/18/17.
//  Copyright © 2017 Kai Jendo. All rights reserved.
//

import UIKit

class iContactViewController: UIViewController {

//MARK: IBOutlet
    var arrKhoa = [String]()
    var arrname = [String]()
    var arrJob  = [String]()
    var arrPhone = [String]()
    var arrAvartar = [String]()
    var arrMail = [String]()
    var arrBomon = [String]()
    var contact = [contacts]()
    var searchActive : Bool = false
    var filtered:[String] = []
    
    @IBOutlet weak var mySeach: UISearchBar!
    @IBOutlet weak var lblYourName: UILabel!
    @IBOutlet weak var lblMSV: UILabel!
    @IBOutlet weak var lblClass: UILabel!
    
    @IBOutlet weak var tblContact: UITableView!
    @IBOutlet weak var lblNotification: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUser()
        getTeacher(urlString: "\(get.URL_TEACHER)")
        tblContact.register(UINib(nibName: "configContactTableViewCell", bundle: nil), forCellReuseIdentifier: "configiContact")
        lblYourName.text = name
        lblMSV.text = id
        lblClass.text = myClass
        tblContact.delegate     = self
        tblContact.dataSource   = self
        mySeach.delegate        = self
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let userInformation = UserDefaults.standard.dictionary(forKey: "myuserInformation") {
            _ = userInformation["id"]
            _ = userInformation["name"]
            _ = userInformation["myClass"]
            
            
        }
    }
}
