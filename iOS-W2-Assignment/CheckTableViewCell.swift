//
//  CheckTableViewCell.swift
//  iOS-W2-Assignment
//
//  Created by Van Do on 10/21/16.
//  Copyright © 2016 Van Do. All rights reserved.
//

import UIKit

class CheckTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
