//
//  deatilsContacViewController.swift
//  TTCN-iSocial
//
//  Created by Kai Jendo on 3/20/17.
//  Copyright © 2017 Kai Jendo. All rights reserved.
//

import UIKit
import MessageUI
import SCLAlertView
class deatilsContacViewController: UIViewController, MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate {
    var name     :    String!
    var job      :    String!
    var phone    :    String!
    var mail     :    String!
    var image    :    String!
    
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblKhoa: UILabel!
    @IBOutlet weak var lblBomon: UILabel!
    @IBOutlet weak var lblJob: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblMail: UILabel!
    
    @IBAction func abtnCalling(_ sender: Any) {
        guard let number = URL(string: "telprompt://" + phone) else { return }
        UIApplication.shared.open(number, options: [:], completionHandler: nil)
    }
    @IBAction func abtnMessage(_ sender: Any) {
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.recipients = [phone]
            controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
        } else {
            SCLAlertView().showWarning("Thất bại", subTitle: "Chưa có số điện thoại.")
        }
    }
    @IBAction func abtnMail(_ sender: Any) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            SCLAlertView().showError("Thất bại", subTitle: "Có lỗi trong quá trình gửi Mail.")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateUI() {
        self.lblName.text    = name
        self.lblJob.text     = job
        self.lblPhone.text   = phone
        self.lblMail.text    = mail
        if image != "" {
            let imgURL = URL(string:image)
            if imgURL != nil {
        
        let request = URLRequest(url: imgURL!)
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
                if (response as? HTTPURLResponse) != nil {
                      self.self.imgAvatar.image = UIImage(named: "logo.png")
                    }
                    self.imgAvatar.image = UIImage(data: data! as Data)
                }
                task.resume()
            }
        } else {
            self.self.imgAvatar.image = UIImage(named: "logo.png")
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients([mail])
        mailComposerVC.setSubject("Xin chào")
        mailComposerVC.setMessageBody("Em cần sự trợ giúp..", isHTML: false)
        return mailComposerVC
    }
  
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
}
