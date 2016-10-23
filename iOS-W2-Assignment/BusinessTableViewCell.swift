//
//  BusinessTableViewCell.swift
//  iOS-W2-Assignment
//
//  Created by Van Do on 10/19/16.
//  Copyright © 2016 Van Do. All rights reserved.
//

import UIKit

class BusinessTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var starImageView: UIImageView!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    var business: Business! {
        didSet {
            titleLabel.text = business.name
            distanceLabel.text = business.distance
            addressLabel.text = business.address
            categoryLabel.text = business.categories
            
            if (business.imageURL != nil) {
                thumbImageView.setImageWith(business.imageURL!)
            }
            
            if (business.ratingImageURL != nil) {
                starImageView.setImageWith(business.ratingImageURL!)
            }
            
            reviewLabel.text = String(describing: business.reviewCount?.intValue ?? 0) + ((business.reviewCount?.intValue)! > 1 ? " reviews" : " review")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
