//
//  configContactTableViewCell.swift
//  TTCN-iSocial
//
//  Created by Kai Jendo on 3/18/17.
//  Copyright © 2017 Kai Jendo. All rights reserved.
//

import UIKit

class configContactTableViewCell: UITableViewCell {
//MARK: IBOutlet
    
    @IBOutlet weak var imgAvartar: UIImageView!
    @IBOutlet weak var lblLastname: UILabel!
    @IBOutlet weak var lblPosition: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPhonenumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
