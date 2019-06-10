//
//  BetCell.swift
//  happybets
//
//  Created by Conor Schofield on 6/9/19.
//  Copyright © 2019 Happy Bets LLC. All rights reserved.
//

import UIKit

class BetCell: UITableViewCell {
    @IBOutlet weak var teamPickedLabel: UILabel!
    @IBOutlet weak var pointWageredLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
