//
//  SearchTableViewController.swift
//  GitHalp
//
//  Created by Stephen on 1/19/15.
//  Copyright (c) 2015 Sherwood. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, UITableViewDataSource, UISearchBarDelegate {

  @IBOutlet var tableViewBlarg: UITableView!
  @IBOutlet weak var searchBar: UISearchBar!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      self.tableViewBlarg.dataSource = self
      self.searchBar.delegate = self

  }

  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    //println(searchBar.text)
    NetworkController.sharedNetworkController.fetchSearchTermRepositories(searchBar.text, callback: { (repositories, errorDescription) -> (Void) in

    })
    searchBar.resignFirstResponder()
  }
  // MARK: - Table view data source
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("SEARCH_CELL") as UITableViewCell

    return cell
  }
  
   override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
}




/* From Monday-Tuesday ending 1.20.15

class SearchTableViewController: UITableViewController, UITableViewDataSource, UISearchBarDelegate {
  
  @IBOutlet var tableViewBlarg: UITableView!
  @IBOutlet weak var searchBar: UISearchBar!
  
  var networkController : NetworkController!
  var arrayRepos = [Repository]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableViewBlarg.delegate = self
    self.tableViewBlarg.dataSource = self
    self.searchBar.delegate = self
    
    let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    self.networkController = appDelegate.networkController
    self.networkController.fetchSearchTermRepositories("bob", callback: { (repositories, errorString) -> (Void) in
    })
  }
  
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    println(searchBar.text)
    self.networkController.fetchSearchTermRepositories(searchBar.text, callback: { (repositories, errorDescription) -> (Void) in
      if errorString == nil {
        self.arrayRepos = repositories
        for i in self.arrayRepos {
          println(i.name)
          println(i.author)
          println()
          self.tableViewBlarg.reloadData()
        }
      } else {
        println("Error @ SearchTableViewController callback from NetworkController")
      }
      
    })
    searchBar.resignFirstResponder()
  }
  // MARK: - Table view data source
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("SEARCH_CELL") as UITableViewCell
    if arrayRepos.count != 0 {
      let cellData = arrayRepos[indexPath.row]// as Repository
      cell.textLabel?.text = cellData.name
      cell.detailTextLabel?.text = cellData.author
    }
    return cell
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
} */