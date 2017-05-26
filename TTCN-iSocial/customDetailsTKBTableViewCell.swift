//
//  customDetailsTKBTableViewCell.swift
//  TTCN-iSocial
//
//  Created by Kai Jendo on 3/25/17.
//  Copyright © 2017 Kai Jendo. All rights reserved.
//

import UIKit

class customDetailsTKBTableViewCell: UITableViewCell {
   
    // IBOutlet
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var imgMode: UIImageView!
    @IBOutlet weak var lblSubjectName: UILabel!
    @IBOutlet weak var lblTeacher: UILabel!
    @IBOutlet weak var lblSubjectTime: UILabel!
    @IBOutlet weak var lblSubjectClass: UILabel!
    
    override func
        awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
