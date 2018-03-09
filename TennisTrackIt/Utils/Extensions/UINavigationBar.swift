//
//  UINavigationBar.swift
//  TennisTrackIt
//
//  Created by Annie Persson on 09/03/2018.
//  Copyright © 2018 Annie Persson. All rights reserved.
//

import UIKit

extension UINavigationBar {
  
  public func hideShadow() {
    shadowImage = UIImage()
    layer.shadowOpacity = 0
  }
  
}
