//
//  hadleiMore.swift
//  TTCN-iSocial
//
//  Created by Kai Jendo on 3/28/17.
//  Copyright © 2017 Kai Jendo. All rights reserved.
//

import Foundation
import UIKit

extension iExtraViewController {
    
}

//MARK: Config table
extension iExtraViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrExtra[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "configiMore", for: indexPath) as! moreTableViewCell
        cell.lblMore.text = arrExtra[indexPath.section][indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return arrMenuTitle[section]
    }
}
