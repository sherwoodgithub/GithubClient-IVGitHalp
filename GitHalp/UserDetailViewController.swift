//
//  UserDetailViewController.swift
//  GitHalp
//
//  Created by Stephen on 1/22/15.
//  Copyright (c) 2015 Sherwood. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
  var selectedUser : UserModel!
  
  @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
      self.imageView.image = selectedUser.userImage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
