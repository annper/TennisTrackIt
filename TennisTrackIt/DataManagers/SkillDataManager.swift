//
//  SkillDataManager.swift
//  TennisTrackIt
//
//  Created by Annie Persson on 09/03/2018.
//  Copyright © 2018 Annie Persson. All rights reserved.
//

import Foundation
import SwiftyJSON
import ObjectMapper

protocol SkillInterface {
  func savedSkills() -> SkillList?
  func add(_ skill: Skill) -> Bool
  func update(_ skill: Skill) -> Bool
  func delete(_ skill: Skill)
  func deleteSkill(withId id: Int)
}

class SkillDataManager: BaseDataManager, SkillInterface {
  
  override init() {
    super.init()
    
    fileName = "skills.json"
  }
  
  /// Get all saved skills
  public func savedSkills() -> SkillList? {
    
    guard let json = readFile(atPath: filePath) else {
      return nil
    }
    
    guard let dict = json.dictionaryObject as [String: AnyObject]? else {
      Logger.warn("Failed to convert skill json string to dictionary")
      return nil
    }
    
    return Mapper<SkillList>().map(JSON: dict, toObject: SkillList())
  }
  
  /// Save new goal
  public func add(_ skill: Skill) -> Success {
    return add(skill, updated: false)
  }
  
  /// Update an existing skill
  public func update(_ skill: Skill) -> Success {

    deleteSkill(withId: skill.id)

    return add(skill, updated: true)
  }
  
  /// Delete skill
  public func delete(_ skill: Skill) {
    deleteSkill(withId: skill.id)
  }

  /// Delete skill with id
  public func deleteSkill(withId id: Int) {

    // Get all saved skills
    guard let savedList = savedSkills() else {
      Logger.warn("There are currently no saved goals")
      return
    }

    // Filter out the skill to be deleted from the current skill list
    let filteredSkills = savedList.skills.filter({ id != $0.id })
    savedList.skills = filteredSkills

    // Re-save the list
    saveSkillList(savedList)
  }
  
  // MARK: - Private methods
  
  private func add(_ skill: Skill, updated: Bool) -> Success {
    let isNewSkill: Bool = !updated
    let hasUniqueTitle: Bool
    
    var skillList = SkillList()
    var id = 1
    
    if let savedList = savedSkills() {
      skillList = savedList
      
      if isNewSkill {
        // Set a unique id by finding the highest current id and increment by one
        id = (skillList.skills.map({ $0.id }).max() ?? 1) + 1
        hasUniqueTitle = skillList.hasSkillWithSameTitle(asSkill: skill)
        guard hasUniqueTitle else { return false }
      }
    }
    
    // Set new skill id or use the old one depending on if this is an update or not
    skill.id = isNewSkill ? id : skill.id
    
    // Add the new/updated skill to the list
    skillList.skills.append(skill)
    
    // Save the list
    saveSkillList(skillList)
    
    return true
  }
  
  private func saveSkillList(_ skillList: SkillList) {
    
    // Convert GoalList object into a string
    guard let jsonString = skillList.toJSONString() else {
      Logger.warn("Failed to convert skill list into json string")
      return
    }
    
    // Save the skill list
    saveToFile(named: fileName, inFolder: folderName, withContent: jsonString)
    
  }
  
}
