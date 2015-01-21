//
//  MenuTableViewController.swift
//  GitHalp
//
//  Created by Stephen on 1/19/15.
//  Copyright (c) 2015 Sherwood. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {

  var networkController : NetworkController!
    override func viewDidLoad() {
        super.viewDidLoad()
      
      let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
      self.networkController = appDelegate.networkController
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
  }
  
  override func viewDidAppear(animated: Bool) {
    if self.networkController.accessToken == nil {
      self.networkController.requestAccessToken()
    }
  }
}
