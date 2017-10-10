//
//  resultsTableViewCell.swift
//  DineWithoutDosh
//
//  Created by Sushant Balajee on 1/10/17.
//  Copyright © 2017 Sushant Balajee. All rights reserved.
//

import UIKit

class resultsTableViewCell: UITableViewCell {

    @IBOutlet weak var restLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var distLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
