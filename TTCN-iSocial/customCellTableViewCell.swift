//
//  customCellTableViewCell.swift
//  TTCN-iSocial
//
//  Created by Kai Jendo on 4/6/17.
//  Copyright © 2017 Kai Jendo. All rights reserved.
//

import UIKit

class customCellTableViewCell: UITableViewCell {

    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDes: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
