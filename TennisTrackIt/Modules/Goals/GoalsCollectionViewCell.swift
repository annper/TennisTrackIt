//
//  GoalsCollectionViewCell.swift
//  TennisTrackIt
//
//  Created by Annie Persson on 01/03/2018.
//  Copyright © 2018 Annie Persson. All rights reserved.
//

import UIKit

class GoalsCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet var titleLabel: UILabel!
  
  func setupCell() {
    layer.cornerRadius = 10
    titleLabel.text = "hi!"
  }
  
}
