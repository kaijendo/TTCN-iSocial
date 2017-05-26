//
//  handleiSound.swift
//  TTCN-iSocial
//
//  Created by Kai Jendo on 3/6/17.
//  Copyright © 2017 Kai Jendo. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

extension iSoundViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrMenu.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMenu[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellForSoundMenu", for: indexPath) as! configCellTableViewCell
        cell.lblTitle.text = arrMenu[indexPath.section][indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
                return arrHeader[section]
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let vc = self.storyboard?.instantiateViewController(withIdentifier: "\(arrVC[indexPath.section][indexPath.row])")
        self.navigationController?.pushViewController(vc!, animated: true)
        
        
        
    }
    

}





