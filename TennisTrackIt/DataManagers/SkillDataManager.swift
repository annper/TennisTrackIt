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

class SkillDataManager: BaseDataManager {
  
  
  override init() {
    super.init()
    
    fileName = "skills.json"
  }
  
}
