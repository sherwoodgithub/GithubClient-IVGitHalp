//
//  UserModel.swift
//  GitHalp
//
//  Created by Stephen on 1/21/15.
//  Copyright (c) 2015 Sherwood. All rights reserved.
//

import UIKit

struct UserModel {
  let name : String
  let userURL : String
  var userImage : UIImage?
  
  init (jsonDictionary : [String : AnyObject]) {
    self.name = jsonDictionary["login"] as String
    self.userURL = jsonDictionary["avatar_url"] as String
  }

}
