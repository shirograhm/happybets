//
//  PlaceBetViewController.swift
//  happybets
//
//  Created by Xavier Graham on 6/8/19.
//  Copyright © 2019 Happy Bets LLC. All rights reserved.
//

import UIKit
import Firebase

class PlaceBetViewController: UIViewController {

    @IBOutlet weak var lowPointBound: UILabel!
    @IBOutlet weak var highPointBound: UILabel!
    @IBOutlet weak var teamSelect: UISegmentedControl!
    @IBOutlet weak var pointSlider: UISlider!
    @IBOutlet weak var pointsDisplay: UILabel!
    
    @IBAction func sliderUpdated(_ sender: UISlider) {
        pointsDisplay.text = String(Int(sender.value))
    }
    
    @IBAction func betSubmitted(_ sender: UIButton) {
        // Ask confirmation
        
        let team1Chosen = (teamSelect.selectedSegmentIndex == 0)
        // Create new bet model
        BetModel.storeBet(pts: Int(pointSlider!.value), uID: Auth.auth().currentUser!.uid, gm: gameChosen, tm1: team1Chosen)
    }
    
    var gameChosen: GameModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let pointMin = 10
        let pointMax = 100
        // Smallest bet is 10 points
        lowPointBound.text = String(pointMin)
        highPointBound.text = String(pointMax)
        
        pointSlider.minimumValue = Float(pointMin)
        pointSlider.maximumValue = Float(pointMax)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
