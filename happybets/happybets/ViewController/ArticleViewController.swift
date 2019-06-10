//
//  ArticleViewController.swift
//  happybets
//
//  Created by user155240 on 6/9/19.
//  Copyright © 2019 Happy Bets LLC. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {

    var article : Article?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = article!.title
        bodyLabel.numberOfLines = 0
        bodyLabel.text = article!.body
        // Do any additional setup after loading the view.
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
