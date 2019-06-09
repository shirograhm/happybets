//
//  NewsViewController.swift
//  happybets
//
//  Created by user155240 on 6/8/19.
//  Copyright © 2019 Happy Bets LLC. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let news = NewsModel()
        
        news.retrieveArticles(closure : displayArticles)
        
        
        // Do any additional setup after loading the view.
    }
    
    func displayArticles(articleList : [Article]){
        print(articleList[0].title)
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
