//
//  Skill.swift
//  TennisTrackIt
//
//  Created by Annie Persson on 02/03/2018.
//  Copyright © 2018 Annie Persson. All rights reserved.
//

import Foundation
import ObjectMapper

class SkillList: Mappable {
  
  public var skills: [Skill] = []
  
  public struct SectionedSkills {
    var sections: [String]
    var skills: [[Skill]]
  }
  
  // MARK: - Mappable
  
  public required convenience init?(map: Map) {
    self.init()
  }
  
  public func mapping(map: Map) {
    skills <- map["skills"]
  }
  
  // MARK: - Public methods
  
  public func getSectionedSkills() -> SectionedSkills {
    
    let sections = skills.map({ $0.category.rawValue }).removeDuplicates()
    var sectionedSkills = Array(repeatElement([Skill](), count: sections.count))

    let sortedSkills = skills.sorted { $0.category.rawValue < $1.category.rawValue }
    
    sectionedSkills = sortedSkills.reduce(into: sectionedSkills) { (result, skill) in
      let index = Int(sections.index(of: skill.category.rawValue) ?? 0)
      result[index].append(skill)
    }
    
    return SectionedSkills(sections: sections, skills: sectionedSkills)
  }
  
}

class Skill: Mappable {
  
  public var id: Int = 0
  public var title: String = ""
  public var tags: [Tag] = []
  public var description: String?
  public var category: SkillCategory = .other
  
  // MARK: - Mappable
  
  public required convenience init?(map: Map) {
    self.init()
  }
  
  public func mapping(map: Map) {
    id <- map["id"]
    title <- map["title"]
    tags <- map["tags"]
    description <- map["description"]
    category <- (map["category"], EnumTransform<SkillCategory>())
  }
  
}

enum SkillCategory: String {
  case footwork = "Footwork"
  case tactics = "Tactics"
  case groundstrokes = "Groundstrokes"
  case volleys = "Volleys"
  case serves = "Serves"
  case ros = "Return of serve"
  case special = "Speciality shots"
  case other = "Other"
}
