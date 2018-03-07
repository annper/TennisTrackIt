//
//  String.swift
//  TennisTrackIt
//
//  Created by Annie Persson on 04/03/2018.
//  Copyright © 2018 Annie Persson. All rights reserved.
//

extension String {
  
  public var isBlank: Bool {
    return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
  }
  
  func performBackspace() -> String {
    
    return String(self[..<self.index(before: self.endIndex)])    
  }
  
}
