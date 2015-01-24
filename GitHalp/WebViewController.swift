//
//  WebViewController.swift
//  GitHalp
//
//  Created by Stephen on 1/22/15.
//  Copyright (c) 2015 Sherwood. All rights reserved.
//

import UIKit
import WebKit

class WebViewController : UIViewController {
  let webView = WKWebView()
  var url : String!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.webView.frame = self.view.frame
    self.view.addSubview(self.webView)
    let request = NSURLRequest(URL: NSURL(string: self.url)!)
    self.webView.loadRequest(request)
  }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}
