//
//  Repository.swift
//  GitHalp
//
//  Created by Stephen on 1/19/15.
//  Copyright (c) 2015 Sherwood. All rights reserved.
//

import Foundation

struct Repository {
  var json : [String : AnyObject]
  var name : String
  var author : String
  
  init (jsonDictionary : [String : AnyObject]) {
    self.json = jsonDictionary as [String : AnyObject]
    self.name = json["name"] as String
    let ownerDictionary = json["owner"] as [String : AnyObject]
    self.author = ownerDictionary["login"] as String
  }
}