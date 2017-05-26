//
//  handleLogin.swift
//  TTCN-iSocial
//
//  Created by Kai Jendo on 2/28/17.
//  Copyright © 2017 Kai Jendo. All rights reserved.
//

import Foundation
import UIKit
import SCLAlertView
import Firebase

extension loginViewController {
//MARK: Animation Slide Show
    func animateView() {
        UIView.animate(withDuration: 5) {
            self.imgLogo.alpha = 1
        }
        UIView.animate(withDuration: 3, delay: 1, options: [.repeat, .autoreverse], animations: {
            self.imgFill1.alpha = 1
            self.imgFill2.alpha = 0
            self.imgFill3.alpha = 1
            self.imgFill4.alpha = 0
        }) { (animated) in
            if self.imgFill1.alpha == 0 {
                self.imgFill2.alpha = 1
                self.imgFill1.alpha = 1
                self.imgFill4.alpha = 0
            }; if self.imgFill2.alpha == 0 {
                self.imgFill3.alpha = 1
                self.imgFill1.alpha = 0
                self.imgFill2.alpha = 1
            }; if self.imgFill3.alpha == 0 {
                self.imgFill3.alpha = 1
                self.imgFill1.alpha = 0
                self.imgFill4.alpha = 1
            }; if self.imgFill4.alpha == 0 {
                self.imgFill4.alpha = 1
                self.imgFill3.alpha = 0
                self.imgFill2.alpha = 0
            }
        }
    }
 
//MARK : config keyboard will hidden or show
    func show(_ notification:NSNotification)
    {
        let valueKeyboard:NSValue = notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        let sizeKeyboard:CGRect = valueKeyboard.cgRectValue
        constraintSDT.constant = sizeKeyboard.size.height + 10
        UIView.animate(withDuration: 1) {
            self.view.layoutSubviews()
        }
    }
    func hide(_ notification:NSNotification)
    {
        constraintSDT.constant = 0
        UIView.animate(withDuration: 1) {
            self.view.layoutSubviews()
        }
    }
    
//MARK: Login get token
    func loginGetToken(){
        getLogin(mUser: txtMSV.text!, mPass: txtPassword.text!, mPhone: txtPhone.text!, mFrom: resultFrom!)
    }
    
    func configLoadingView() {
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = view.center
        loadingView.backgroundColor = UIColor.black
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        activityIndicatorView.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        loadingView.addSubview(activityIndicatorView)
        view.addSubview(loadingView)
        activityIndicatorView.startAnimating()
        loadingView.isHidden = true
        
    }

    func getLogin(mUser: String, mPass: String, mPhone:String, mFrom: String) {
        configLoadingView()
        if mUser == "" && mPass == "" && mPhone == "" {
            showWait.hideView()
            showError.showError("Thất bại", subTitle: "Bạn chưa nhập thông tin...", duration: 3, animationStyle: .bottomToTop)
        } else if mUser == "" || mPass == "" || mPhone == "" {
            showWait.hideView()
            showError.showError("Thất bại", subTitle: "Bạn cần nhập đủ thông tin...", duration: 3, animationStyle: .bottomToTop)
        } else {
            let url = URL(string: "\(get.URL_LOGIN)&app-id=\(get.APP_ID)&app-secret=\(get.APP_SECRET)&username=\(mUser)&password=\(mPass)&\(get.FROM)=\(mFrom)")!
            let data = try! Data(contentsOf: url)
            let result = try? JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
            if let result2 = result?["access-token"] as? String {
                resultFinal = "\(result2)"
                showWait.hideView()
                let userInfo = ["MSV": mUser, "password": mPass,"phone": mPhone,"from":mFrom]
                UserDefaults.standard.set(userInfo, forKey: "userInformation")
                status = true
                showSuccess.addButton("Đồng ý", action: {
                    let main = self.storyboard?.instantiateViewController(withIdentifier: "main")
                    FIRAuth.auth()?.signInAnonymously(completion: { (user, error) in
                        if let err = error {
                            print(err.localizedDescription)
                            return
                        }
                    })
                    self.present(main!, animated: true, completion: nil)
                })
                showSuccess.showSuccess("Thành công", subTitle: "Chuyển tới màn chính?", closeButtonTitle: "Đóng",animationStyle: .bottomToTop)
                self.dismiss(animated: true, completion: nil)
                return
            } else if let result3 = result?["msg"] as? String {
                showWait.hideView()
                status = false
                showError.showError("Thất bại", subTitle: "\(result3)", duration: 3, animationStyle: .bottomToTop)
            }
        }
    }
// MARK: Get status user login or not
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let userInformation = UserDefaults.standard.dictionary(forKey: "userInformation") {
            let mMSV = userInformation["MSV"] as! String
            let mPassword = userInformation["password"] as! String
            let mPhoneNumber = userInformation["phone"] as! String
            let mFrom = userInformation["from"] as! String
            getLogin(mUser: mMSV, mPass: mPassword, mPhone: mPhoneNumber, mFrom: mFrom)
            DispatchQueue.main.async {
                if status == true {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "main")
                    self.self.present(vc!, animated: true, completion: nil)
                } else {
                    let vc1 = self.storyboard?.instantiateViewController(withIdentifier: "login")
                    self.self.present(vc1!, animated: true, completion: nil)
                }
            }
        
        }
    }
}

//MARK: Save session and check session user login

extension loginViewController {
    
    func dismissKeyboard() {
        view.endEditing(true)
    }

    
}
// MARK: Config Custom PickerView Delegate
extension loginViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrSchool.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch row {
        case 0:
            resultFrom = arrSchool[0]
        case 1:
            resultFrom = arrSchool[1]
        case 2:
            resultFrom = arrSchool[2]
        default:
            resultFrom = arrSchool[3]
        }
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let myView = UIView(frame: CGRect(x: 0, y: 0, width: pickerView.bounds.width - 30, height: 30))
        let myImageView =  UIImageView(frame: CGRect(x:0, y: 5, width: 20, height: 20))
        var rowString = String()
        switch row {
        case 0:
            rowString = "ĐH Công nghệ thông tin và truyền thông"
            myImageView.image = UIImage(named:"DTC.png")
        case 1:
            rowString = "ĐH Kinh tế và quản trị kinh doanh"
            myImageView.image = UIImage(named:"DTE.png")
        case 2:
            rowString = "ĐH Khoa học"
            myImageView.image = UIImage(named:"DTZ.png")
        default:
            rowString = "Khoa ngoại ngữ"
            myImageView.image = UIImage(named:"DTF.png")
        }
        let myLabel = UILabel(frame: CGRect(x: 30, y: 0, width: pickerView.bounds.width - 20, height: 30))
        myLabel.text = rowString
        myLabel.font = UIFont(name: "Time New Roman", size: 7)
        myView.addSubview(myLabel)
        myView.addSubview(myImageView)
        return myView
    }
}

