//
//  Array.swift
//  TennisTrackIt
//
//  Created by Annie Persson on 12/03/2018.
//  Copyright © 2018 Annie Persson. All rights reserved.
//

import Foundation

extension Array where Element: Hashable {
  
  public func removeDuplicates() -> [Element] {
    return self.reduce([]) { (result, element) -> [Element] in
      return result.contains(element) ? result : result + [element]
    }
  }
  
}
