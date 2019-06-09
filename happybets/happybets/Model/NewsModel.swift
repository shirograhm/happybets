//
//  NewsModel.swift
//  happybets
//
//  Created by Xavier Graham on 5/23/19.
//  Copyright © 2019 Happy Bets LLC. All rights reserved.
//

import Foundation

class NewsModel {
    var articleList : [Article]?
    
    init() {
        articleList = []
    }
    
    
    func retrieveArticles(closure : @escaping ([Article])->Void){
        let todoEndpoint: String = createUrl()
        guard let url = URL(string: todoEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let task : URLSessionDataTask = session.dataTask(with: urlRequest) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                print("error calling GET on /todos/1")
                print(error!)
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            // parse the result as JSON, since that's what the API provides
            do {
                /*guard let jsonResponse = try JSONSerialization.jsonObject(with: responseData, options: [])
                    as? [String: [String:Any]] else {
                        print("error trying to convert data to JSON")
                        return
                }*/
                
                let decoder = JSONDecoder()
                let results = try decoder.decode(ArticleList.self, from: responseData)
                //self.articleList = results.articles.list
                
                closure(results.articles.list)
                
                // the todo object is a dictionary
                // so we just access the title using the "title" key
                // so check for a title and print it if we have one
                /*guard let todoTitle = jsonResponse["title"] as? String else {
                 print("Could not get todo title from JSON")
                 return
                 }*/
                
                //self.parseJsonFile(json:jsonResponse)
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
        }
        task.resume()
        
    }
    
    func createUrl() -> String {
        var url = "https://eventregistry.org/api/v1/article/getArticles?query=%7B%22%24query%22%3A%7B%22%24and%22%3A%5B%7B%22conceptUri%22%3A%22http%3A%2F%2Fen.wikipedia.org%2Fwiki%2FNBA_Finals%22%7D%2C%7B%22categoryUri%22%3A%22dmoz%2FSports%2FBasketball%2FProfessional%22%7D%2C%7B%22%24or%22%3A%5B%7B%22sourceUri%22%3A%22espn.com%22%7D%5D%7D%2C%7B%22dateStart%22%3A%22"
        
        var date = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd"
        
        let endDate = formatter.string(from: date)
        
        date = date - 604800
        
        let startDate = formatter.string(from: date)
        
        print(startDate)
        print(endDate)
        
        url = url + startDate + "%22%2C%22dateEnd%22%3A%22" + endDate + "%22%2C%22lang%22%3A%22eng%22%7D%5D%7D%7D&dataType=news&resultType=articles&articlesSortBy=rel&articlesCount=10&articleBodyLen=-1&apiKey=de25d70a-1050-41dd-baf0-8e13ba47a6c3&"
        return url
    }}
