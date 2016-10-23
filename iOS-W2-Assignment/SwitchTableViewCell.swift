//
//  SwitchTableViewCell.swift
//  iOS-W2-Assignment
//
//  Created by Van Do on 10/21/16.
//  Copyright © 2016 Van Do. All rights reserved.
//

import UIKit

@objc protocol SwitchTableViewCellDelegate {
    @objc optional func switchChanged(_ sender: SwitchTableViewCell)
}

class SwitchTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var enableSwitch: UISwitch!
    
    weak var delegate: SwitchTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func onSwitchChanged(_ sender: AnyObject) {
        delegate?.switchChanged?(self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
