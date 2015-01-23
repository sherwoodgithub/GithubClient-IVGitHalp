//
//  ToUserDetailAnimationController.swift
//  GitHalp
//
//  Created by Stephen on 1/22/15.
//  Copyright (c) 2015 Sherwood. All rights reserved.
//

import UIKIt

class ToUserDetailAnimateionController : NSObject, UIViewControllerAnimatedTransitioning {
  
  func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
    return 0.4
  }
  func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as UserDetailViewController
    let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as SearchUsersViewController
    let containerView = transitionContext.containerView()
    let indexPath = fromVC.collectionView.indexPathsForSelectedItems().first as NSIndexPath
    let cell = fromVC.collectionView.cellForItemAtIndexPath(indexPath) as UserCell
    let snapshotOfCell = cell.userCellImageView.snapshotViewAfterScreenUpdates(false)
    cell.userCellImageView.hidden = true
    snapshotOfCell.frame = containerView.convertRect(cell.userCellImageView.frame, fromView: cell.userCellImageView.superview)
    
    toVC.view.frame = transitionContext.finalFrameForViewController(toVC)
    toVC.view.alpha = 0
    toVC.imageView.hidden = true
    containerView.addSubview(toVC.view)
    containerView.addSubview(snapshotOfCell)
    
    toVC.view.setNeedsLayout()
    toVC.view.layoutIfNeeded()
    
    let duration = self.transitionDuration(transitionContext)
    UIView.animateWithDuration(duration, animations: { () -> Void in
      toVC.view.alpha = 1.0
      let frame = containerView.convertRect(toVC.imageView.frame, fromView: toVC.view)
      snapshotOfCell.frame = frame
      }) { (finished) -> Void in
        toVC.imageView.hidden = false
        cell.userCellImageView.hidden = false
        snapshotOfCell.removeFromSuperview()
        transitionContext.completeTransition(true)
    }
  }
}
