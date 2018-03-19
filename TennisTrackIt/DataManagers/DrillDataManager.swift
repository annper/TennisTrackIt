//
//  DrillDataManager.swift
//  TennisTrackIt
//
//  Created by Annie Persson on 19/03/2018.
//  Copyright © 2018 Annie Persson. All rights reserved.
//

import Foundation
import ObjectMapper
import SwiftyJSON

protocol DrillInterface {
  func savedDrills() -> DrillList?
  func add(_ drill: Drill)
  func update(_ drill: Drill)
  func delete(_ drill: Drill)
  func deleteDrill(withId id: Int)
  func updateSortSetting(to sortType: SortType)
}

class DrillDataManager: BaseDataManager, DrillInterface {
  
  override init() {
    super.init()
    
    fileName = "drills.json"
  }
  
  // MARK: - Public methods
  
  func savedDrills() -> DrillList? {
    Logger.info("load saved drills")
    return nil
  }
  
  public func add(_ drill: Drill) {
    Logger.info("Add drill")
  }
  
  public func update(_ drill: Drill) {
    Logger.info("Update drill")
  }
  
  public func delete(_ drill: Drill) {
    Logger.info("delete drill")
  }
  
  public func deleteDrill(withId id: Int) {
    Logger.info("dekete frill")
  }
  
  public func updateSortSetting(to sortType: SortType) {
    Logger.info("update sort setting")
  }
  
  // MARK: - Private methods
  
  
}
