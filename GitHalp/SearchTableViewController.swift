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
  
  let networkController = NetworkController()
  var arrayRepos = [Repository]()
  
    override func viewDidLoad() {
        super.viewDidLoad()
      self.tableViewBlarg.delegate = self
      self.tableViewBlarg.dataSource = self
      self.searchBar.delegate = self
      self.networkController.fetchSearchTermRepositories("bob", callback: { (repositories, errorString) -> (Void) in
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
  }

  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    println(searchBar.text)
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
//    WHY ????????????????????
    if arrayRepos.count == 0 {
      return 1
    } else {
      return arrayRepos.count
    }
  }
  
  
  /*
      override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
          // #warning Potentially incomplete method implementation.
          // Return the number of sections.
          return 0
      }
  */
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
