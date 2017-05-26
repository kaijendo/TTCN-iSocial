//
//  customNoteTableViewCell.swift
//  TTCN-iSocial
//
//  Created by Kai Jendo on 4/5/17.
//  Copyright © 2017 Kai Jendo. All rights reserved.
//

import UIKit

class customNoteTableViewCell: UITableViewCell {
    @IBOutlet weak var lblContents: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
