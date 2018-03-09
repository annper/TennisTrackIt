//
//  GoalDataManager.swift
//  TennisTrackIt
//
//  Created by Annie Persson on 02/03/2018.
//  Copyright © 2018 Annie Persson. All rights reserved.
//

import Foundation
import SwiftyJSON
import ObjectMapper

class GoalDataManager: BaseDataManager {
  
  override init() {
    super.init()
    
    fileName = "goals.json"
  }
  
//  private let fileName: String = "goals.json"
//  private let folderName: String = "data"
//  private var filePath: String {
//    return "\(folderName)/\(fileName)"
//  }
  
  /// Get all saved goals
  public func savedGoals() -> GoalList? {
    
    guard let json = readFile(atPath: filePath) else {
      return nil
    }
    
    guard let dict = json.dictionaryObject as [String: AnyObject]? else {
      Logger.warn("Failed to convert goal json string to dictionary")
      return nil
    }
    
    return Mapper<GoalList>().map(JSON: dict, toObject: GoalList())
  }
  
  /// Save new goal
  public func add(_ goal: Goal) {
    add(goal, updated: false)
  }
  
  private func add(_ goal: Goal, updated: Bool) {
    let isNewGoal: Bool = !updated

    // Get the saved GoalList if there is one
    var goalList = GoalList()
    var id = 1
    
    if let savedList = savedGoals() {
      goalList = savedList
      
      if isNewGoal {
        // Set a unique id by finding the highest current id and increment by one
        id = (goalList.goals.map({ $0.id }).max() ?? 1) + 1
      }
    }
    
    // Set the goal id if this is a new goal ( Updated goals already have an id )
    if isNewGoal {
      goal.id = id
    }
    
    // Append the new goal to the list of existing ones
    goalList.goals.append(goal)
    
    // Convert GoalList object into a string
    saveGoalList(goalList)
    
  }
  
  /// Update an existing goal
  public func update(_ goal: Goal) {
    
    deleteGoal(withId: goal.id)
    
    add(goal, updated: true)
  }
  
  /// Delete goal
  public func delete(_ goal: Goal) {
    deleteGoal(withId: goal.id)
  }
  
  /// Delete goal with id
  public func deleteGoal(withId id: Int) {
    
    // Get all saved goals
    guard let savedList = savedGoals() else {
      Logger.warn("There are currently no saved goals")
      return
    }
    
    // Filter out the goal to be deleted from the current goal list
    let filteredGoals = savedList.goals.filter({ id != $0.id })
    savedList.goals = filteredGoals
    
    // Re-save the list
    saveGoalList(savedList)
    
  }
  
  /// Save the goal list with a new SortType
  public func updateSortSetting(to sortType: SortType) {
    guard let goalList = savedGoals() else {
      Logger.warn("There are currently no saved goals")
      return
    }
    
    goalList.sortType = sortType
    
    saveGoalList(goalList)
  }
  
  // MARK: - Private methods
  
  private func saveGoalList(_ goalList: GoalList) {
    
    // Convert GoalList object into a string
    guard let jsonString = goalList.toJSONString() else {
      Logger.warn("Failed to convert goal list into json string")
      return
    }
    
    // Save the goal list
    saveToFile(named: fileName, inFolder: folderName, withContent: jsonString)
    
  }
  
  private func findSavedGoal(withId id: Int) -> Goal? {
    
    guard let savedList = savedGoals() else {
      Logger.warn("There are currently no saved goals")
      return nil
    }
    
    guard let thisGoal = savedList.findGoal(withId: id) else {
      Logger.warn("Unable to find saved goal with id: \(id)")
      return nil
    }
    
    return thisGoal
  }
  
}
