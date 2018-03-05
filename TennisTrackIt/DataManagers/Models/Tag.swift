//
//  Tag.swift
//  TennisTrackIt
//
//  Created by Annie Persson on 02/03/2018.
//  Copyright © 2018 Annie Persson. All rights reserved.
//

import Foundation
import ObjectMapper

class Tag: Mappable {
  
  public var id: Int = 0
  public var type: TagType = .goal { didSet {
    rawType = type.rawValue
  }}
  
  private var rawType: String = "goal"
  
  // MARK: - Mappable
  
  public required convenience init?(map: Map) {
    self.init()
  }
  
  public func mapping(map: Map) {
    rawType <- map["rawType"]
    id <- map["id"]
  }
  
}

enum TagType: String {
  case goal = "goal"
  case skill = "skill"
  case drill = "drill"
}
