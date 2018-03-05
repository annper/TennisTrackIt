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
  
  public var sortType: SortType = .createdDate
  public var goals: [Goal] = []

  // MARK: - Mappable
  
  public required convenience init?(map: Map) {
    self.init()
  }
  
  public func mapping(map: Map) {
    goals <- map["goals"]
    sortType <- (map["sortType"], EnumTransform<SortType>())
  }
  
  // MARK: - Public methods
  
  func findGoal(withId id: Int) -> Goal? {
    return goals.filter({ id == $0.id }).first
  }
  
  func sortedGoals() -> [Goal] {
    switch sortType {
    case .alphabetic:
      return goals.sorted { $0.title < $1.title }
    case .createdDate:
      return goals.sorted { $0.id > $1.id }
    }
  }

}

// MARK: - SortType

enum SortType: String {
  case alphabetic = "alphabetic"
  case createdDate = "createdDate"
  
  func sortDescriptor(_ type: SortType) -> String {
    let selected: String = "✔︎"
    let title: String
    
    switch type {
    case .alphabetic:
      title = "Alphabetically"
    case .createdDate:
      title = "Last edited"
    }
    
    return type == self ? "\(title) \(selected)" : title
  }
}

// MARK: - Goal

class Goal: Mappable {
  
  public var id: Int = 0
  public var createdDate: Date = Date()
  public var title: String = ""
  public var tags: [Tag] = []
  public var description: String?
  public var completed: Bool = false
  
  // MARK: - Mappable
  
  public required convenience init?(map: Map) {
    self.init()
  }
  
  public func mapping(map: Map) {
    id <- map["id"]
    createdDate <- (map["createdDate"], DateTransform())
    title <- map["title"]
    tags <- map["tags"]
    description <- map["description"]
    completed <- map["completed"]
  }
  
}
