//
//  createContactViewController.swift
//  TTCN-iSocial
//
//  Created by Kai Jendo on 3/21/17.
//  Copyright © 2017 Kai Jendo. All rights reserved.
//

import UIKit

class createContactViewController: UIViewController {
    
//IBOutlet
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var pickerKhoa: UIPickerView!
    @IBOutlet weak var txtMon: UITextField!
    @IBOutlet weak var pickerJob: UIPickerView!
    @IBOutlet weak var txtNumber: UITextField!
    @IBOutlet weak var txtMail: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
