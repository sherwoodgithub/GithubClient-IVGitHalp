//
//  NetworkController.swift
//  GitHalp
//
//  Created by Stephen on 1/19/15.
//  Copyright (c) 2015 Sherwood. All rights reserved.
//

import Foundation

class NetworkController {
  
  var urlSession : NSURLSession
  
  init() {
    
    self.urlSession = NSURLSession(configuration: NSURLSessionConfiguration.ephemeralSessionConfiguration())
  }
  // callback param linked with callback below
  func fetchSearchTermRepositories(searchTerm: String, callback : ([Repository], String?) -> (Void)) {
    let url = NSURL(string: "http://127.0.0.1:3000")
    let dataTask = self.urlSession.dataTaskWithURL(url!, completionHandler: { (data, urlResponse, error) -> Void in
      if error == nil {
        if let httpResponse = urlResponse as? NSHTTPURLResponse {
          println(httpResponse.statusCode)
          switch httpResponse.statusCode {
          case 200...299:
            if let json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as? [String : AnyObject] {
              let arrayRepo = json["items"] as? [[String : AnyObject]]
              var arrayResult = [Repository]()

              for i in arrayRepo! {
                let repo = Repository(jsonDictionary: i)
                arrayResult.append(repo)
              }
              
              NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                callback(arrayResult, nil)
              })
            }
          case 400...599:
            println("case 400 - 599")
          default:
            println("default fired fetchSearchTermRepositories")
          }
        }
      }
    })
    dataTask.resume()
  }
}
