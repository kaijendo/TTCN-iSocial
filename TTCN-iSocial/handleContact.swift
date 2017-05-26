


//
//  handleContact.swift
//  TTCN-iSocial
//
//  Created by Kai Jendo on 3/19/17.
//  Copyright © 2017 Kai Jendo. All rights reserved.
//

import Foundation
import UIKit

extension iContactViewController {
    func getTeacher(urlString: String) {
        let url = NSURL(string: urlString)
        URLSession.shared.dataTask(with: (url as URL?)!, completionHandler: {(data, response, error) -> Void in
            let json = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [[String:Any]]
            for i in json! {
                if let result = i["khoa"] as? String {
                    self.arrKhoa.append(result)
                }
                if let result = i["list"] as? [[String: Any]] {
                    for i in result {
                        let result2 = i["bomon"] as! String
                        self.arrBomon.append(result2)
                        self.tblContact.reloadData()
                        let result3 = i["list"] as! [[String:Any]]
                        for i in result3 {
                        let result4 = i["phone"] as! String
                        self.arrPhone.append(result4)
                        var result5 = i["name"] as! String
                        result5.replace("\r", with: "")
                        result5.replace("Họ và tên:", with: "")
                         result5.replace("()", with: "")   
                        self.arrname.append(result5)
                        let result6 = i["mail"]
                            if result6 is NSNull {
                                self.arrMail.append("Chưa cập nhập")
                            } else {
                                self.arrMail.append(result6 as! String)
                            }
                        let result7 = i["job"] as! String
                        self.arrJob.append(result7)
                        let result8 = i["avatar"] as! String
                        self.arrAvartar.append(result8)
                        }
                    }
                }
            }
            if self.arrname.count != 0 {
                self.lblNotification.isHidden = true
            }
            OperationQueue.main.addOperation({
                self.tblContact.reloadData()
            })
        }).resume()
    }
    
    func getUser() {
        let user = ["id":id,"name":name,"myClass":myClass]
        let defaults = UserDefaults.standard
        let url = URL(string: "\(get.HOME_SCHOOL)api=get&path=user&\(get.TOCKEN_KEY)=\(resultFinal!)")
        let data = try! Data(contentsOf: url!)
        let result = try? JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
        let result1 = result?["data"] as! [String:Any]
        id = result1["id"] as! String
        name = result1["name"] as! String
        myClass = result1["class"] as! String
        defaults.set(user, forKey: "myuserInformation")
    }
}

extension iContactViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filtered.count
        }
        return arrname.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "configiContact", for: indexPath) as! configContactTableViewCell
        cell.lblLastname.text = "\(arrname[indexPath.row])"
        cell.lblPosition.text = "\(arrJob[indexPath.row])"
        cell.lblEmail.text = "\(arrMail[indexPath.row])"
        cell.lblPhonenumber.text = "\(arrPhone[indexPath.row])"
       cell.imgAvartar.image = UIImage(named: "logo.png")
        return cell
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "detailContacts") as! deatilsContacViewController
            vc.name     = "\(arrname[indexPath.row])"
            vc.job      = arrJob[indexPath.row]
            vc.phone    = arrPhone[indexPath.row]
            vc.mail     = arrMail[indexPath.row]
            vc.image    = arrAvartar[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            if indexPath.row - 1 == requestRow {

                requestRow += 10
                tblContact.reloadData()
            }
        }
}

extension iContactViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filtered = arrname.filter({ (text) -> Bool in
            let tmp: NSString = text as NSString
            let range = tmp.range(of: searchText, options: .caseInsensitive)
            return range.location != NSNotFound
        })
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.tblContact.reloadData()
    }
}
