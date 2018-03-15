//
//  GoalsCollectionViewCell.swift
//  TennisTrackIt
//
//  Created by Annie Persson on 01/03/2018.
//  Copyright © 2018 Annie Persson. All rights reserved.
//

import UIKit

/*
 * How to setup dynamic sized cells: https://medium.com/@wasinwiwongsak/uicollectionview-with-autosizing-cell-using-autolayout-in-ios-9-10-84ab5cdf35a2
 */
class GoalsCollectionViewCell: UICollectionViewCell {
  
  // MARK: - Private properties
  
  private var goal: Goal!
  private var indexPath: IndexPath!
  private var removeGoal: ((_ goal: Goal, _ indexPath: IndexPath) -> Void)!
  
  private let screenWidth: CGFloat = UIScreen.main.bounds.width
  private let edgeInsets: CGFloat = 10 * 2 // Left and right edge insets set in the Collection View
  
  // MARK: - IBOutlets
  
  @IBOutlet var statusIconImageView: UIImageView! { didSet {
    statusIconImageView.image?.withRenderingMode(.alwaysTemplate)
    statusIconImageView.tintColor = UIColor.white
  }}
  
  @IBOutlet var titleLabel: UILabel!
  
  @IBOutlet var tagLabel: UILabel!
  
  @IBOutlet var descLabel: UILabel!
  
  @IBOutlet var containerView: UIView! { didSet {
    containerView.layer.borderColor = UIColor(red: 0.298, green: 0.298, blue: 0.298, alpha: 1).cgColor
    containerView.layer.borderWidth = 2
    containerView.layer.cornerRadius = 10
    containerView.clipsToBounds = true
  }}
  
  @IBOutlet var containerViewWidthConstraint: NSLayoutConstraint! { didSet {
    containerViewWidthConstraint.constant = screenWidth - (edgeInsets)
  }}
  
  @IBAction func didTapRemoveButton(_ sender: UIButton) {
    Logger.info("Remove goal with id: \(goal.id)")
    removeGoal(goal, indexPath)
  }
  
  // MARK: - UICollectionViewCell
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    contentView.translatesAutoresizingMaskIntoConstraints = false
  }
  
  // MARK - Public methods
  
  func setupCell(withCellItem item: GoalCellItem) {
    self.goal = item.goal
    self.indexPath = item.indexPath
    self.removeGoal = item.removeGoalAction
    
    titleLabel.text = item.goal.title
    descLabel.text = item.goal.description
    
    setStatusIcon()
  }
  
  // MARK: - Private methods
  
  private func setStatusIcon() {
    let imageName = goal.completed ? "completed" : "in-progress"
    
    statusIconImageView.image = UIImage(named: imageName)
  }
  
}

// MARK: - GoalCellItem

struct GoalCellItem {
  var indexPath: IndexPath
  var goal: Goal
  var removeGoalAction: ((_ goal: Goal, _ indexPath: IndexPath) -> Void)
}
