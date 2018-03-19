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
  
  typealias Section = String
  typealias SkillSection = [Skill]
  public var sortType: SortType = .alphabetic
  public var skills: [Skill] = []
  
  public struct SectionedSkills {
    var sections: [Section]
    var skills: [SkillSection]
  }
  
  // MARK: - Mappable
  
  public required convenience init?(map: Map) {
    self.init()
  }
  
  public func mapping(map: Map) {
    skills <- map["skills"]
    sortType <- (map["sortType"], EnumTransform<SortType>())
  }
  
  // MARK: - Public methods
  
  /// Sees if a skill with the same title already exists among the currenlty saved skills.
  /// - parameter skill: The skill being comopared
  /// - returns: true if another skill with the same title already exists, otherwise false
  public func hasSkillWithSameTitle(asSkill skill: Skill) -> Bool {
    let skillWithSameTitle = skills.filter({ ($0.title == skill.title) && ($0.id != skill.id) })
    return skillWithSameTitle.count > 0
  }
  
  /// Turn the array of currently saved skills into sectioned data that can be used with a sectioned table view.
  /// - returns: SectionedSkills - Includes skills divided into Cell row and Section data
  public func getSectionedSkills() -> SectionedSkills {
    
    let sections = skills.map({ $0.category.rawValue }).removeDuplicates()
    var sectionedSkills = Array(repeatElement([Skill](), count: sections.count))
    
    sectionedSkills = skills.reduce(into: sectionedSkills) { (result, skill) in
      let index = Int(sections.index(of: skill.category.rawValue) ?? 0)
      result[index].append(skill)
    }
    
    return SectionedSkills(sections: sections, skills: sectionedSkills)
  }
  
  /// Filter skills based on the passed string
  /// - parameter searchText: the String that must be included in a skills title for it to be included in the result
  /// - returns: SectionedSkills - Filtered sections and skills
  public func getFilteredSkills(searchText: String) -> SectionedSkills {
    
    let unfilteredSectionedSkills = getSectionedSkills()
    
    let filteredSkills = filterSkills(basedOn: searchText, unfilteredSkills: unfilteredSectionedSkills.skills)
    let filteredCategories = filterCategories(basedOnSkills: filteredSkills)

    return SectionedSkills(sections: filteredCategories, skills: filteredSkills)
  }
  
  /// Sorts the skills data according to the currently set SortType
  /// - returns: SectionedSkills sorted according to the current GoalList sortType
  public func sorted() -> SectionedSkills {
    
    let sectionedSkills = getSectionedSkills()
    let skills = sectionedSkills.skills
    let sections = sectionedSkills.sections
    
    switch sortType {
    case .alphabetic:
      return sortAlphabetically(skills: skills, sections: sections)
    case .reverseAlphabetic:
      return sortReverseAlphabetically(skills: skills, sections: sections)
    default:
      return sectionedSkills
    }
    
  }
  
  // MARK - Private methods
  
  /// Sort skills + sections in alphabetical order
  /// - parameters: sectionedSkills
  /// - returns: SectionedSkills - The sorted result
  private func sortAlphabetically(skills: [SkillSection], sections: [Section]) -> SectionedSkills {
    let innerSorted = skills.map({ $0.sorted( by: { $0.title < $1.title }) })
    let outerSorted = innerSorted.sorted(by: { $0[0].category.rawValue < $1[0].category.rawValue })
    
    let sortedSections = sections.sorted(by: { $0 < $1 })
    
    return SectionedSkills(sections: sortedSections, skills: outerSorted)
  }
  
  /// Sort skills + sections in  reverse alphabetical order
  /// - parameters: sectionedSkills
  /// - returns: SectionedSkills - The sorted result
  private func sortReverseAlphabetically(skills: [SkillSection], sections: [Section]) -> SectionedSkills {
    let innerSorted = skills.map({ $0.sorted(by: { $0.title > $1.title }) })
    let outerSorted = innerSorted.sorted(by: { $0[0].category.rawValue > $1[0].category.rawValue })
    
    let sortedSections = sections.sorted(by: { $0 > $1 })
    
    return SectionedSkills(sections: sortedSections, skills: outerSorted)
  }
  
  private func filterCategories(basedOnSkills skills: [SkillSection]) -> [Section] {
    
    return skills.flatMap({ $0 }).map({ $0.category.rawValue }).removeDuplicates()
  }
  
  private func filterSkills(basedOn searchText: String, unfilteredSkills: [SkillSection]) -> [SkillSection] {
    
    let searchText = searchText.lowercased()
    
    return unfilteredSkills.reduce([]) { (result, skillArray) -> [SkillSection] in
      
      let matchingSkillsArray = skillArray.filter({ (skill) -> Bool in
        let nsString = skill.title.lowercased() as NSString
        return nsString.contains(searchText)
      })
      
      if matchingSkillsArray.isEmpty {
        return result
      } else {
        return result + [matchingSkillsArray]
      }
    }
    
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
  
  static public var allValues: [String] {
    return [
      "Footwork",
      "Tactics",
      "Groundstrokes",
      "Volleys",
      "Serves",
      "Return of serve",
      "Speciality shots",
      "Other"
    ]
  }
}
