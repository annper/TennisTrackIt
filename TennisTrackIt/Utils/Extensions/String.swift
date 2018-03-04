//
//  String.swift
//  TennisTrackIt
//
//  Created by Annie Persson on 04/03/2018.
//  Copyright © 2018 Annie Persson. All rights reserved.
//

extension String {
  
  func performBackspace() -> String {
    
    return String(self[..<self.index(before: self.endIndex)])    
  }
  
}
