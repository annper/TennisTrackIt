//
//  Goal.swift
//  TennisTrackIt
//
//  Created by Annie Persson on 02/03/2018.
//  Copyright © 2018 Annie Persson. All rights reserved.
//

import Foundation
import ObjectMapper

// MARK: - GoalList

class GoalList: Mappable {
  
  public var goals: [Goal] = []
  
  // MARK: - Mappable
  
  public required convenience init?(map: Map) {
    self.init()
  }
  
  public func mapping(map: Map) {
    goals <- map["goals"]
  }
  
  // MARK: - Public methods
  
  func findGoal(withId id: Int) -> Goal? {
    return goals.filter({ id == $0.id }).first
  }

}

// MARK: - Goal

class Goal: Mappable {
  
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
