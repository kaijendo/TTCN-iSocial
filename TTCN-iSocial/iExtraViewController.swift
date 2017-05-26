//
//  iExtraViewController.swift
//  TTCN-iSocial
//
//  Created by Kai Jendo on 3/28/17.
//  Copyright © 2017 Kai Jendo. All rights reserved.
//

import UIKit

class iExtraViewController: UIViewController {
//MARK: variable
    
    var arrMenuTitle:[String] = ["TRA CỨU", "TIỆN ÍCH"]
    var arrExtra:[[String]] =
        [["Tra cứu thời gian","Tra cứu lịch thi","Tra cứu điểm"],["Xe ôm"]]
    
//MARK: IBOutlet
    @IBOutlet weak var tblExtra: UITableView!

    @IBAction func abtnLogout(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tblExtra.register(UINib(nibName: "moreTableViewCell", bundle: nil), forCellReuseIdentifier: "configiMore")
        tblExtra.delegate = self
        tblExtra.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
