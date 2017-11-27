//
//  favouritesTableViewCell.swift
//  FindAFeed
//
//  Created by Sushant Balajee on 21/11/17.
//  Copyright © 2017 Sushant Balajee. All rights reserved.
//

import UIKit

class favouritesTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var featureImage: UIImageView!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var restLabel: UILabel!
    //@IBOutlet weak var featureImage: UIImageView!
    //@IBOutlet weak var restLabel: UILabel!
    //@IBOutlet weak var costLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
