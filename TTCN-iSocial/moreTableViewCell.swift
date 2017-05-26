//
//  moreTableViewCell.swift
//  TTCN-iSocial
//
//  Created by Kai Jendo on 3/28/17.
//  Copyright © 2017 Kai Jendo. All rights reserved.
//

import UIKit

class moreTableViewCell: UITableViewCell {
//MARK: variable
 
    
//MARK: IBOutlet
    @IBOutlet weak var lblMore: UILabel!
    @IBOutlet weak var imgMore: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
