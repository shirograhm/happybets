//
//  PlayerCell.swift
//  happybets
//
//  Created by Conor Schofield on 6/7/19.
//  Copyright © 2019 Happy Bets LLC. All rights reserved.
//

import UIKit

class PlayerCell: UITableViewCell {
    @IBOutlet weak var standingLabel: UILabel!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setLabels(standing: String, playerName: String, points: String) {
        standingLabel.text = standing
        playerNameLabel.text = playerName
        pointLabel.text = points
    }
}
