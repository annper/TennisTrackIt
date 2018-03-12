//
//  SkillDetailVC.swift
//  TennisTrackIt
//
//  Created by Annie Persson on 12/03/2018.
//  Copyright © 2018 Annie Persson. All rights reserved.
//

import UIKit

class SkillDetailVC: UIViewController {
  
  // MARK: - Public properties
  
  public var skill: Skill!
  
  // MARK: - UIViewController
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = skill.title
    Logger.info("SkillDetailVC")
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
    Logger.warn("didReceiveMemoryWarning")
  }
  
}
