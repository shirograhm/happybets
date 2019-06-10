//
//  GameTableViewCell.swift
//  happybets
//
//  Created by Xavier Graham on 6/9/19.
//  Copyright © 2019 Happy Bets LLC. All rights reserved.
//

import UIKit

class GameTableViewCell: UITableViewCell {

    
    @IBOutlet weak var homeTeamLabel: UILabel!
    @IBOutlet weak var awayTeamLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
