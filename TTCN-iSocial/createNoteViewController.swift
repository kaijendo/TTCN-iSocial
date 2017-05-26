//
//  createNoteViewController.swift
//  TTCN-iSocial
//
//  Created by Kai Jendo on 3/30/17.
//  Copyright © 2017 Kai Jendo. All rights reserved.
//

import UIKit

class createNoteViewController: UIViewController {
//MARK: IBOutlet

    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var lblAlarmStatus: UILabel!
    @IBOutlet weak var lblSwitchStatus: UILabel!
    @IBOutlet weak var txtContents: UITextView!
    @IBOutlet weak var lblDate: UILabel!
//MARK: IBAction
    
    @IBAction func abtnAdd(_ sender: Any) {
    }
    @IBAction func abtnAlarm(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblDate.isHidden = true
        btnAdd.layer.cornerRadius = btnAdd.frame.size.width/2
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)

}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
