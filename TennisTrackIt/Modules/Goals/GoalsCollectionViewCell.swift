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
  
  let screenWidth: CGFloat = UIScreen.main.bounds.width
  let edgeInsets: CGFloat = 10 * 2 // Left and right edge insets set in the Collection View
  
  // MARK: - IBOutlets
  
  @IBOutlet var titleLabel: UILabel!
  
  @IBOutlet var tagLabel: UILabel!
  
  @IBOutlet var descLabel: UILabel!
  
  @IBOutlet var containerView: UIView! { didSet {
    containerView.layer.borderColor = UIColor.black.cgColor
    containerView.layer.borderWidth = 2
    containerView.layer.cornerRadius = 10
    containerView.clipsToBounds = true
  }}
  
  @IBOutlet var containerViewWidthConstraint: NSLayoutConstraint! { didSet {
    containerViewWidthConstraint.constant = screenWidth - (edgeInsets)
  }}
  
  // MARK: - UICollectionViewCell
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    contentView.translatesAutoresizingMaskIntoConstraints = false
  }
  
  // MARK - Public methods
  
  func setupCell(withGoal goal: Goal) {
    titleLabel.text = goal.title
    descLabel.text = goal.description ?? ""
  }
  
}
