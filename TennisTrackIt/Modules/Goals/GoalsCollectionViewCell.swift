//
//  GoalsCollectionViewCell.swift
//  TennisTrackIt
//
//  Created by Annie Persson on 01/03/2018.
//  Copyright © 2018 Annie Persson. All rights reserved.
//

import UIKit

class GoalsCollectionViewCell: UICollectionViewCell {
  
  // MARK: - Private properties
  
  let screenWidth: CGFloat = UIScreen.main.bounds.width
  let edgeInsets: CGFloat = 10 * 2 // Left and right edge insets set in the Collection View
  
  // MARK: - IBOutlets
  
  @IBOutlet var titleLabel: UILabel!
  
  @IBOutlet var tagLabel: UILabel!
  
  @IBOutlet var descLabel: UILabel!
  
  @IBOutlet var containerViewWidthConstraint: NSLayoutConstraint! { didSet {
    containerViewWidthConstraint.constant = screenWidth - (edgeInsets)
  }}
  
  // MARK - Public methods
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    contentView.translatesAutoresizingMaskIntoConstraints = false
    layer.cornerRadius = 10
  }
  
  func setupCell(withText text: String) {
    descLabel.text = text
  }
  
}
