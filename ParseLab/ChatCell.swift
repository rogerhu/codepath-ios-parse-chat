//
//  ChatCell.swift
//  ParseLab
//
//  Created by Roger Hu on 9/26/17.
//  Copyright © 2017 Roger Hu. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {

    @IBOutlet weak var msgText: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
