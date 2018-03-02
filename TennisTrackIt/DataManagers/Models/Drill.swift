//
//  Drill.swift
//  TennisTrackIt
//
//  Created by Annie Persson on 02/03/2018.
//  Copyright © 2018 Annie Persson. All rights reserved.
//

import Foundation
import ObjectMapper

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
