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
  }

  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    if NetworkController.sharedNetworkController.accessToken == nil {
      NetworkController.sharedNetworkController.requestAccessToken()
    }
    
    let alertView = NSBundle.mainBundle().loadNibNamed("menuAlertView", owner: self, options: nil).first as UIView
    alertView.center = self.view.center
    alertView.alpha = 0
    alertView.transform = CGAffineTransformMakeScale(0.4, 0.4)
    self.view.addSubview(alertView)
    
    UIView.animateWithDuration(0.4, delay: 0.5, options: nil, animations: { () -> Void in
      alertView.alpha = 1
      alertView.transform = CGAffineTransformMakeScale(1.0, 1.0)
      }) { (finished) -> Void in
    }
  }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}
