//
//  SearchUsersViewController.swift
//  GitHalp
//
//  Created by Stephen on 1/21/15.
//  Copyright (c) 2015 Sherwood. All rights reserved.
//

import UIKit

class SearchUsersViewController: UIViewController, UICollectionViewDataSource, UISearchBarDelegate, UINavigationControllerDelegate {

  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var searchBar: UISearchBar!
  
  var users = [UserModel]()
  
    override func viewDidLoad() {
        super.viewDidLoad()
      self.collectionView.dataSource = self
      self.searchBar.delegate = self
      self.navigationController?.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("USER_CELL", forIndexPath: indexPath) as UserCell
    // ! 3.3.2 30.5min
    cell.userCellImageView.image = nil
    var user = self.users[indexPath.row]
    if user.userImage == nil {
      NetworkController.sharedNetworkController.fetchUserImageForURL(user.userURL, completionHandler: { (image) -> (Void) in
        cell.userCellImageView.image = image
        user.userImage = image
        self.users[indexPath.row] = user
      })
    } else {
      cell.userCellImageView.image = user.userImage
    }
    return cell
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.users.count
  }
  //MARK: delegate search bar
  
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    // vid 3.3.2 30min :
    NetworkController.sharedNetworkController.fetchSearchTermUsers(searchBar.text, callback: { (users, errorString) -> (Void) in
      if errorString == nil {
        self.users = users!
        self.collectionView.reloadData()
      }
    })
  }
  
  func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    if toVC is UserDetailViewController {
      return ToUserDetailAnimateionController()
    }
    return nil
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "SHOW_USER_DETAIL" {
      let destinationVC = segue.destinationViewController as UserDetailViewController
      let indexPath = self.collectionView.indexPathsForSelectedItems().first as NSIndexPath
      destinationVC.selectedUser = self.users[indexPath.row]
    }
  }
}
