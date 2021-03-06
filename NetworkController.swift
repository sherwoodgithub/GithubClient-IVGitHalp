//
//  NetworkController.swift
//  GitHalp
//
//  Created by Stephen on 1/19/15.
//  Copyright (c) 2015 Sherwood. All rights reserved.
//

import UIKit

class NetworkController {
  //MIKE WHY THIS SETUP
  class var sharedNetworkController : NetworkController {
    struct Static {
      static let instance : NetworkController = NetworkController()
    }
    return Static.instance
  }
  
  let imageQueue = NSOperationQueue()
  let clientID = "b43eb11a9dbde33bed4d"
  let clientSecret = "eaac3604e72cab555401356f508623251ddee210"
  var accessTokenUserKeyDefault = "accessToken"
  var accessToken : String?
  var urlSession : NSURLSession
  
  init() {
    self.urlSession = NSURLSession(configuration: NSURLSessionConfiguration.ephemeralSessionConfiguration())
    if let accessToken = NSUserDefaults.standardUserDefaults().objectForKey(self.accessTokenUserKeyDefault) as? String {
    self.accessToken = accessToken
    }
  }
  
  func requestAccessToken () {
    let url = "https://github.com/login/oauth/authorize?client_id=\(clientID)&scope=user,repo,notifications,admin:org"
    UIApplication.sharedApplication().openURL(NSURL(string: url)!)
  }
  
  func urlHandler(url: NSURL) {
    let code = url.query
    let oauthURL = "https://github.com/login/oauth/access_token?\(code!)&client_id=\(self.clientID)&client_secret=\(self.clientSecret)"
    let postRequest = NSMutableURLRequest(URL: NSURL(string: oauthURL)!)
    postRequest.HTTPMethod = "POST"
    
    let dataTask = self.urlSession.dataTaskWithRequest(postRequest, completionHandler: { (data, response, error) -> Void in
      if error == nil {
        if let httpResponse = response as? NSHTTPURLResponse {
          switch httpResponse.statusCode {
          case 200...299:
            let tokenReponse = NSString(data: data, encoding: NSASCIIStringEncoding)
            println(tokenReponse)
            
            let accessTokenComponent = tokenReponse?.componentsSeparatedByString("&").first as String
            let accessToken = accessTokenComponent.componentsSeparatedByString("=").last
            NSUserDefaults.standardUserDefaults().setObject(accessToken!, forKey: self.accessTokenUserKeyDefault)
            NSUserDefaults.standardUserDefaults().synchronize()
            
          case 300...399:
            println("urHandler 300-399")
          case 400...499:
              println("urHandler 400-499")
          case 500...599:
                println("urHandler 500-599")
          default:
            println("default case during func urlHandler")
          }
        }
      }
    })
    dataTask.resume()
  }
  
  // callback param linked with callback below
  func fetchSearchTermRepositories(searchTerm: String, callback : ([Repository], String?) -> (Void)) {
    let url = NSURL(string: "https://api.github.com/search/repositories?q=\(searchTerm)")
    
    let request = NSMutableURLRequest(URL: url!)
    request.setValue("token \(self.accessToken)", forHTTPHeaderField: "Authorization")
    
    let dataTask = self.urlSession.dataTaskWithURL(url!, completionHandler: { (data, urlResponse, error) -> Void in
      if error == nil {
        if let httpResponse = urlResponse as? NSHTTPURLResponse {
          //println(httpResponse.statusCode)
          switch httpResponse.statusCode {
          case 200...299:
            //println(httpResponse)
            let jsonDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as [String : AnyObject]
            println(jsonDictionary)
          
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
  
  func fetchSearchTermUsers(searchTerm : String, callback : ([UserModel]?, String?) -> (Void)) {
    let url = NSURL(string: "https://api.github.com/search/users?q=\(searchTerm)")
    let request = NSMutableURLRequest(URL: url!)
    // this line prevents rate limit. We're doing a simple GET
    request.setValue("token \(self.accessToken!)", forHTTPHeaderField: "Authorization")
    
    // let's use our urlSession: using the one that takes in a request & completion handler so we can set the header field and pass in our token
    let dataTask = self.urlSession.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
      if error == nil {
        if let httpResponse = response as? NSHTTPURLResponse {
          switch httpResponse.statusCode {
            case 200...299:
              if let jsonDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as? [String : AnyObject] {
                if let arrayItems = jsonDictionary["items"] as? [[String: AnyObject]] {
                  var users = [UserModel]()
                  for item in arrayItems {
                    let user = UserModel(jsonDictionary: item)
                    users.append(user)
                  }
                  NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    callback(users, nil)
                  })
                }
              }
            default:
              println("default case on user search, status code : \(httpResponse.statusCode)")
          }
        }
      } else {
        println(error.localizedDescription)
      }
    })
    dataTask.resume()
  }
  
  func fetchUserImageForURL(url : String, completionHandler : (UIImage) -> (Void)) {
    let url = NSURL(string: url)
    self.imageQueue.addOperationWithBlock { () -> Void in
      var imageData = NSData(contentsOfURL: url!)
      var image = UIImage(data: imageData!)
      NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
        completionHandler(image!)
      })
    }
  }
}

/* fetchSearchTermRepositories from Mon-Tues ending 1.20.15

func fetchSearchTermRepositories(searchTerm: String, callback : ([Repository], String?) -> (Void)) {
  let url = NSURL(string: "https://api.github.com/search/repositories?q=\(searchTerm)")
  
  let request = NSMutableURLRequest(URL: url!)
  request.setValue("token \(self.accessToken)", forHTTPHeaderField: "Authorization")
  
  let dataTask = self.urlSession.dataTaskWithURL(url!, completionHandler: { (data, urlResponse, error) -> Void in
    if error == nil {
      if let httpResponse = urlResponse as? NSHTTPURLResponse {
        println(httpResponse.statusCode)
        switch httpResponse.statusCode {
        case 200...299:
          println(httpResponse)
          let jsonDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as [String : AnyObject]
          println(jsonDictionary)
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
*/
