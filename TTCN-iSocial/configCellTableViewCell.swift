//
//  configCellTableViewCell.swift
//  TTCN-iSocial
//
//  Created by Kai Jendo on 3/15/17.
//  Copyright © 2017 Kai Jendo. All rights reserved.
//

import UIKit

class configCellTableViewCell: UITableViewCell {
//MARK: IBOutlet
    
    @IBOutlet weak var imgTitle: UIImageView!
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
