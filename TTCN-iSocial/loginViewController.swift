//
//  loginViewController.swift
//  TTCN-iSocial
//
//  Created by Kai Jendo on 2/28/17.
//  Copyright © 2017 Kai Jendo. All rights reserved.
//

import UIKit

class loginViewController: UIViewController, UITextFieldDelegate {
       
//MARK: Variable
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
    var loadingView: UIView = UIView()
    var activityIndicatorView:UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
//MARK: IBOutlet
    @IBOutlet weak var srollView: UIScrollView!
    @IBOutlet weak var txtMSV: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var bottomLayoutGuideConstraint: NSLayoutConstraint!
    @IBOutlet weak var imgFill4: UIImageView!
    @IBOutlet weak var imgFill3: UIImageView!
    @IBOutlet weak var imgFill2: UIImageView!
    @IBOutlet weak var imgFill1: UIImageView!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var constraintSDT: NSLayoutConstraint!
    @IBOutlet weak var imgLogo: UIImageView! {
        didSet {imgLogo.alpha = 0}}
    @IBOutlet weak var pickerSchool: UIPickerView!
    
//MARK: Action
    @IBAction func abtnLogin(_ sender: Any) {
        configLoadingView()
        loginGetToken()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        txtMSV.delegate         = self
        txtPassword.delegate    = self
        txtPhone.delegate       = self
        animateView()
        pickerSchool.delegate   = self
        pickerSchool.dataSource = self
        
        view.addGestureRecognizer(tap)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShowNotification(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHideNotification(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShowNotification(_ notification: Notification) {
        let keyboardEndFrame = ((notification as NSNotification).userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let convertedKeyboardEndFrame = view.convert(keyboardEndFrame, from: view.window)
        bottomLayoutGuideConstraint.constant = view.bounds.maxY - convertedKeyboardEndFrame.minY
    }
    
    func keyboardWillHideNotification(_ notification: Notification) {
        bottomLayoutGuideConstraint.constant = 48
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            txtMSV.endEditing(true)
            txtPassword.endEditing(true)
            txtPhone.endEditing(true)
            return true
        }
    }
}
