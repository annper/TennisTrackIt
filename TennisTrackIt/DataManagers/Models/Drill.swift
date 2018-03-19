//
//  Drill.swift
//  TennisTrackIt
//
//  Created by Annie Persson on 02/03/2018.
//  Copyright © 2018 Annie Persson. All rights reserved.
//

import Foundation
import ObjectMapper

class DrillList: Mappable {
  
  public var groupBy: GroupSetting = .title
  public var drills: [Drill] = []
  
  // MARK: - Mappable
  
  public required convenience init?(map: Map) {
    self.init()
  }
  
  public func mapping(map: Map) {
    groupBy <- (map["groupBy"], EnumTransform<GroupSetting>())
    drills <- map["drills"]
  }
  
  // MARK: - Public mathods
  
  public func grouped() -> ([[Drill]], [String]) {
    
    // TODO: - Implement grouping methods
    
    switch groupBy {
    case .title:
      return ([drills], ["Section title"])
    default:
      return ([drills], ["Section titile"])
    }
    
  }
  
}

class Drill: Mappable {
  
  public var id: Int = 0
  public var title: String = ""
  public var tags: [Tag] = []
  public var description: String?
  
  // MARK: - Mappable
  
  public required convenience init?(map: Map) {
    self.init()
  }
  
  public func mapping(map: Map) {
    id <- map["id"]
    title <- map["title"]
    tags <- map["tags"]
    description <- map["description"]
  }
}

enum GroupSetting: String {
  case title = "Title"
  case skill = "Skill"
}
