//
//  UICollectionView.swift
//  TennisTrackIt
//
//  Created by Annie Persson on 05/03/2018.
//  Copyright © 2018 Annie Persson. All rights reserved.
//

import UIKit

extension UICollectionView {
  
  var indexPathForSelectedItem: IndexPath? {
    return self.indexPathsForSelectedItems?.first
  }
  
}
