//
//  configSeachTableViewCell.swift
//  TTCN-iSocial
//
//  Created by Kai Jendo on 3/16/17.
//  Copyright © 2017 Kai Jendo. All rights reserved.
//

import UIKit

class configSeachTableViewCell: UITableViewCell {

    @IBOutlet weak var lblQuality: UILabel!
    @IBOutlet weak var lblArtist: UILabel!
    @IBOutlet weak var lblSource: UILabel!
    @IBOutlet weak var lblNameSong: UILabel!
    @IBOutlet weak var imgSong: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
