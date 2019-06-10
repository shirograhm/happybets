//
//  NewsViewController.swift
//  happybets
//
//  Created by user155240 on 6/8/19.
//  Copyright © 2019 Happy Bets LLC. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {

    var articleList : [Article] = []
    
    @IBOutlet weak var newsTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let news = NewsModel()
        
        news.retrieveArticles(closure: displayArticles)
        
        // Do any additional setup after loading the view.
    }
    
    func displayArticles(alist : [Article]){
        articleList = alist
        
        print(alist[0].title)
        self.newsTable.reloadData()
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

extension NewsViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(articleList.count)
        return articleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsTable.dequeueReusableCell(withIdentifier: "article", for: indexPath) as! articleViewCell
        cell.articleTitle.text = articleList[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(60)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "articleSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ArticleViewController
        {
            destination.article = articleList[(newsTable.indexPathForSelectedRow?.row)!]
        }
    }
}
